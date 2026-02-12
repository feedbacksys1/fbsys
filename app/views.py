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
