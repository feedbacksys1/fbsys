"""
Контекст-процессоры приложения app.
"""
from django.urls import reverse


def user_profile(request):
    """
    Добавляет в контекст шаблонов профиль текущего пользователя (или None),
    чтобы в base.html можно было показывать разный пункт меню для студентов и кураторов.
    """
    profile = None
    if getattr(request, 'user', None) and request.user.is_authenticated:
        profile = getattr(request.user, 'profile', None)
    return {'user_profile': profile}


def notifications(request):
    """
    Добавляет в контекст количество уведомлений по заявкам для текущего пользователя.

    Для студентов:
      - notif_status_updates: количество заявок, у которых статус уже не «Новый».
    Для кураторов:
      - notif_new_requests: количество заявок со статусом «Новый».
    """
    from .models import Profile, Role, StudentRequest, FeedbackStatus

    user = getattr(request, 'user', None)
    notif_new_requests = 0
    notif_status_updates = 0

    if not user or not user.is_authenticated:
        return {
            'notif_new_requests': notif_new_requests,
            'notif_status_updates': notif_status_updates,
        }

    try:
        profile = user.profile
        role = profile.role
    except Profile.DoesNotExist:
        role = Role.STUDENT

    last_curator_new_request = None
    last_student_update_request = None

    if role == Role.TEACHER:
        notif_new_requests = StudentRequest.objects.filter(
            recipient=user,
            status=FeedbackStatus.NEW,
        ).count()
        last_curator_new_request = (
            StudentRequest.objects.filter(
                recipient=user,
                status=FeedbackStatus.NEW,
            )
            .order_by('-created_at')
            .select_related('sender')
            .first()
        )
    else:
        qs = StudentRequest.objects.filter(sender=user).exclude(status=FeedbackStatus.NEW)
        notif_status_updates = qs.count()
        last_student_update_request = (
            qs.order_by('-status_changed_at', '-created_at')
            .select_related('recipient')
            .first()
        )

    return {
        'notif_new_requests': notif_new_requests,
        'notif_status_updates': notif_status_updates,
        'last_curator_new_request': last_curator_new_request,
        'last_student_update_request': last_student_update_request,
    }


def breadcrumbs(request):
    """
    Добавляет в контекст список хлебных крошек для текущей страницы.
    Каждый элемент: {"url": url или None, "label": "Текст"}.
    """
    breadcrumbs_list = []
    url_name = getattr(getattr(request, 'resolver_match', None), 'url_name', None)
    if not url_name:
        return {'breadcrumbs': breadcrumbs_list}

    # Не показываем хлебные крошки на лендинге и странице регистрации
    if url_name in ('landing', 'site_register'):
        return {'breadcrumbs': []}

    # Обычные страницы сайта
    main_pages = {
        'about': ('about', 'О нас'),
        'advantages': ('advantages', 'Преимущества'),
        'faq': ('faq', 'FAQ'),
        'request_rules': ('request_rules', 'Правила подачи заявок'),
        'student_guide': ('student_guide', 'Инструкция для студентов'),
        'feedback': ('feedback', 'Обратная связь'),
        'contacts': ('contacts', 'Контакты'),
        'site_login': ('site_login', 'Вход'),
        'site_register': ('site_register', 'Регистрация'),
        'settings': ('settings', 'Настройки'),
    }
    if url_name in main_pages:
        breadcrumbs_list.append({'url': reverse('landing'), 'label': 'Главная'})
        _, label = main_pages[url_name]
        breadcrumbs_list.append({'url': None, 'label': label})
        return {'breadcrumbs': breadcrumbs_list}

    # Личный кабинет / Панель управления
    if url_name == 'cabinet':
        breadcrumbs_list.append({'url': reverse('landing'), 'label': 'Главная'})
        try:
            profile = getattr(request.user, 'profile', None)
            role = getattr(profile, 'role', None)
            from .models import Role
            label = 'Панель управления' if role == Role.TEACHER else 'Личный кабинет'
        except Exception:
            label = 'Личный кабинет'
        breadcrumbs_list.append({'url': None, 'label': label})
        return {'breadcrumbs': breadcrumbs_list}

    # Админ-панель
    admin_pages = {
        'admin_statistics': 'Просмотр статистики',
        'admin_feedback_list': 'Просмотр обратной связи',
        'admin_users': 'Управление пользователями',
    }
    if url_name in admin_pages:
        breadcrumbs_list.append({'url': reverse('admin_statistics'), 'label': 'Админ панель'})
        breadcrumbs_list.append({'url': None, 'label': admin_pages[url_name]})
        return {'breadcrumbs': breadcrumbs_list}

    # Неизвестная страница — хотя бы Главная
    breadcrumbs_list.append({'url': reverse('landing'), 'label': 'Главная'})
    breadcrumbs_list.append({'url': None, 'label': 'Страница'})
    return {'breadcrumbs': breadcrumbs_list}
