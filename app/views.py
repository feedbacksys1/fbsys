"""
Представления основного приложения.
"""
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, logout
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth import get_user_model
from django.db.models import Q
from django.utils import timezone

from django.contrib import messages

from .forms import RegistrationForm, LoginForm
from .models import Profile, Role, GeneralFeedback, FeedbackStatus

User = get_user_model()


def landing(request):
    """
    Главная (лендинг) страница сервиса обратной связи.
    """
    return render(request, 'landing.html')


def contacts(request):
    """
    Страница контактов.
    """
    return render(request, 'contacts.html')


def feedback(request):
    """
    Страница обратной связи (общая форма для пользователей сайта).
    """
    if request.method == 'POST':
        name = (request.POST.get('name') or '').strip()
        email = (request.POST.get('email') or '').strip()
        phone = (request.POST.get('phone') or '').strip()
        topic = (request.POST.get('topic') or '').strip()
        message_text = (request.POST.get('message') or '').strip()
        if not name or not email or not message_text:
            messages.error(request, 'Заполните обязательные поля: Имя, Email, Сообщение.')
            return render(request, 'feedback.html', {
                'form_name': name,
                'form_email': email,
                'form_phone': phone,
                'form_topic': topic,
                'form_message': message_text,
            })
        try:
            GeneralFeedback.objects.create(
                name=name,
                email=email,
                phone=phone,
                topic=topic,
                message=message_text,
            )
            messages.success(request, 'Ваше сообщение отправлено. Мы рассмотрим его в ближайшее время.')
            return redirect('feedback')
        except Exception:
            messages.error(request, 'Не удалось отправить сообщение. Попробуйте позже.')
            return render(request, 'feedback.html', {
                'form_name': name,
                'form_email': email,
                'form_phone': phone,
                'form_topic': topic,
                'form_message': message_text,
            })
    return render(request, 'feedback.html')


def login_view(request):
    """
    Страница входа.
    """
    if request.user.is_authenticated:
        return redirect('landing')
    if request.method == 'POST':
        form = LoginForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect('landing')
    else:
        form = LoginForm(request)
    return render(request, 'login.html', {'form': form})


def register(request):
    """
    Страница регистрации.
    """
    if request.user.is_authenticated:
        return redirect('landing')
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('landing')
    else:
        form = RegistrationForm()
    return render(request, 'register.html', {'form': form})


def logout_view(request):
    """
    Выход из учётной записи (GET для перехода по ссылке).
    """
    logout(request)
    return redirect('landing')


def _is_staff(user):
    return user.is_authenticated and user.is_staff


@login_required
@user_passes_test(_is_staff, login_url='landing')
def admin_panel(request):
    """
    Кастомная админ-панель сервиса (только для staff).
    """
    return render(request, 'admin_panel.html')


@login_required
@user_passes_test(_is_staff, login_url='landing')
def admin_users(request):
    """
    Управление пользователями: список и смена роли (только для staff).
    """
    if request.method == 'POST':
        for key, new_role in request.POST.items():
            if key.startswith('role_') and new_role in dict(Role.choices):
                try:
                    user_id = int(key.replace('role_', ''))
                except ValueError:
                    continue
                user = get_object_or_404(User, pk=user_id)
                profile, _ = Profile.objects.get_or_create(user=user, defaults={'role': Role.STUDENT})
                profile.role = new_role
                profile.save()
                user.is_staff = new_role == Role.ADMIN
                user.save(update_fields=['is_staff'])
        from django.urls import reverse
        from urllib.parse import urlencode
        url = reverse('admin_users')
        q = request.POST.get('q', '').strip()
        if q:
            url += '?' + urlencode({'q': q})
        return redirect(url)
    users = User.objects.all().order_by('id')
    search_q = request.GET.get('q', '').strip()
    if search_q:
        users = users.filter(
            Q(username__icontains=search_q) | Q(email__icontains=search_q)
        )
    users_with_profiles = []
    for u in users:
        try:
            profile = u.profile
        except Profile.DoesNotExist:
            profile = None
        users_with_profiles.append({'user': u, 'profile': profile})
    return render(request, 'admin_users.html', {
        'users_with_profiles': users_with_profiles,
        'role_choices': Role.choices,
        'search_q': search_q,
    })


@login_required
@user_passes_test(_is_staff, login_url='landing')
def admin_feedback_list(request):
    """
    Просмотр форм обратной связи и смена статусов (только для staff).
    """
    if request.method == 'POST':
        now = timezone.now()
        for key, new_status in request.POST.items():
            if key.startswith('status_') and new_status in dict(FeedbackStatus.choices):
                try:
                    fb_id = int(key.replace('status_', ''))
                except ValueError:
                    continue
                fb = get_object_or_404(GeneralFeedback, pk=fb_id)
                if fb.status != new_status:
                    fb.status = new_status
                    fb.status_changed_at = now
                    fb.status_changed_by = request.user
                    fb.save()
        return redirect('admin_feedback_list')
    feedback_list = GeneralFeedback.objects.all()
    return render(request, 'admin_feedback_list.html', {
        'feedback_list': feedback_list,
        'status_choices': FeedbackStatus.choices,
    })
