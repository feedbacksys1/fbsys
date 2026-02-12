"""
Представления основного приложения.
"""
from django.shortcuts import render, redirect
from django.contrib.auth import login, logout
from django.contrib.auth.decorators import login_required, user_passes_test

from .forms import RegistrationForm, LoginForm


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
            form.save()
            return redirect('site_login')
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
