"""
Представления основного приложения.
"""
from django.shortcuts import render


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
    Страница входа (макет, без подключения к БД).
    """
    return render(request, 'login.html')


def register(request):
    """
    Страница регистрации (макет, без подключения к БД).
    """
    return render(request, 'register.html')
