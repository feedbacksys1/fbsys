"""
Модели приложения app.
"""
from django.db import models
from django.conf import settings


class Role(models.TextChoices):
    ADMIN = 'admin', 'Администратор'
    TEACHER = 'teacher', 'Преподаватель'
    STUDENT = 'student', 'Студент'


class Profile(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='profile',
    )
    role = models.CharField(
        max_length=20,
        choices=Role.choices,
        default=Role.STUDENT,
    )
    student_number = models.CharField(
        max_length=50,
        blank=True,
    )

    class Meta:
        verbose_name = 'профиль'
        verbose_name_plural = 'профили'

    def __str__(self):
        return f'{self.user.get_full_name()} ({self.get_role_display()})'


class FeedbackStatus(models.TextChoices):
    NEW = 'new', 'Новый'
    IN_PROGRESS = 'in_progress', 'В обработке'
    REVIEWED = 'reviewed', 'Рассмотрен'


class GeneralFeedback(models.Model):
    name = models.CharField('Имя', max_length=150)
    email = models.EmailField('Почта')
    phone = models.CharField('Телефон', max_length=50, blank=True)
    topic = models.CharField('Тема', max_length=200, blank=True)
    message = models.TextField('Сообщение')
    status = models.CharField(
        'Статус',
        max_length=20,
        choices=FeedbackStatus.choices,
        default=FeedbackStatus.NEW,
    )
    created_at = models.DateTimeField('Дата отправки', auto_now_add=True)
    status_changed_at = models.DateTimeField('Дата изменения статуса', null=True, blank=True)
    status_changed_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='feedback_status_changes',
        verbose_name='Кто изменил статус',
    )

    class Meta:
        verbose_name = 'обращение обратной связи'
        verbose_name_plural = 'обращения обратной связи'
        ordering = ['-created_at']

    def __str__(self):
        return f'{self.email} — {self.topic or self.message[:50]}'
