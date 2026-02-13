"""
Модели приложения app.
"""
from django.db import models
from django.conf import settings


class Role(models.TextChoices):
    ADMIN = 'admin', 'Администратор'
    TEACHER = 'teacher', 'Куратор'
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


class StudentRequest(models.Model):
    """
    Заявка от студента куратору.
    """
    sender = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='sent_requests',
        verbose_name='Отправитель',
    )
    recipient = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='received_requests',
        verbose_name='Куратор (получатель)',
    )
    topic = models.CharField('Тема', max_length=200, blank=True)
    message = models.TextField('Сообщение')
    created_at = models.DateTimeField('Дата отправки', auto_now_add=True)
    status = models.CharField(
        'Статус',
        max_length=20,
        choices=FeedbackStatus.choices,
        default=FeedbackStatus.NEW,
    )
    status_changed_at = models.DateTimeField(
        'Дата изменения статуса',
        null=True,
        blank=True,
    )
    thread_opened_at = models.DateTimeField(
        'Переписка открыта',
        null=True,
        blank=True,
        help_text='Когда куратор написал первое сообщение в переписке',
    )

    class Meta:
        verbose_name = 'заявка студента'
        verbose_name_plural = 'заявки студентов'
        ordering = ['-created_at']

    def __str__(self):
        topic_preview = (self.topic or self.message)[:50]
        return f'{self.sender.get_username()} → {self.recipient.get_username()}: {topic_preview}'


class StudentRequestMessage(models.Model):
    """Сообщение в переписке по заявке (куратор ↔ студент)."""
    request = models.ForeignKey(
        StudentRequest,
        on_delete=models.CASCADE,
        related_name='thread_messages',
        verbose_name='Заявка',
    )
    author = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='request_messages',
        verbose_name='Автор',
    )
    body = models.TextField('Текст сообщения')
    created_at = models.DateTimeField('Дата отправки', auto_now_add=True)

    class Meta:
        verbose_name = 'сообщение в переписке'
        verbose_name_plural = 'сообщения в переписке'
        ordering = ['created_at']

    def __str__(self):
        return f'{self.author.get_username()} в заявке #{self.request_id}: {self.body[:30]}'


def request_attachment_upload_to(instance, filename):
    """Путь загрузки: request_attachments/request_<id>/<uuid>_<original>."""
    import uuid
    ext = filename.split('.')[-1] if '.' in filename else ''
    safe = (filename[: 50] + '..') if len(filename) > 50 else filename
    return f'request_attachments/request_{instance.request_id}/{uuid.uuid4().hex}_{safe}'


class RequestAttachment(models.Model):
    """Прикреплённый файл к заявке студента (pdf, docx, xlsx и т.д.)."""
    request = models.ForeignKey(
        StudentRequest,
        on_delete=models.CASCADE,
        related_name='attachments',
        verbose_name='Заявка',
    )
    file = models.FileField('Файл', upload_to=request_attachment_upload_to)
    original_name = models.CharField('Имя файла', max_length=255)
    uploaded_at = models.DateTimeField('Дата загрузки', auto_now_add=True)

    class Meta:
        verbose_name = 'вложение заявки'
        verbose_name_plural = 'вложения заявок'
        ordering = ['uploaded_at']

    def __str__(self):
        return self.original_name


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
