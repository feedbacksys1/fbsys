"""
Контекст-процессоры приложения app.
"""


def user_profile(request):
    """
    Добавляет в контекст шаблонов профиль текущего пользователя (или None),
    чтобы в base.html можно было показывать разный пункт меню для студентов и преподавателей.
    """
    profile = None
    if getattr(request, 'user', None) and request.user.is_authenticated:
        profile = getattr(request.user, 'profile', None)
    return {'user_profile': profile}
