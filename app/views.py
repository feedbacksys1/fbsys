"""
Представления основного приложения.
"""
from django.shortcuts import render


def landing(request):
    """
    Главная (лендинг) страница сервиса обратной связи.
    """
    return render(request, 'landing.html')
