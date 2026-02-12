"""
Регистрация моделей в админ-панели.
"""
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.contrib.auth import get_user_model

from .models import Profile, GeneralFeedback

User = get_user_model()


class ProfileInline(admin.StackedInline):
    model = Profile
    can_delete = False
    verbose_name_plural = 'профиль'


class UserAdmin(BaseUserAdmin):
    inlines = (ProfileInline,)


admin.site.unregister(User)
admin.site.register(User, UserAdmin)


@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'role', 'student_number')
    list_filter = ('role',)
    search_fields = ('user__username', 'user__email', 'student_number')


@admin.register(GeneralFeedback)
class GeneralFeedbackAdmin(admin.ModelAdmin):
    list_display = ('email', 'name', 'topic', 'status', 'created_at', 'status_changed_at', 'status_changed_by')
    list_filter = ('status',)
    search_fields = ('name', 'email', 'message', 'topic')
