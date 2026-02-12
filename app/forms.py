"""
Формы приложения app.
"""
from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, PasswordChangeForm
from django.contrib.auth import get_user_model

from .models import Profile, Role

User = get_user_model()


class ProfileSettingsForm(forms.Form):
    first_name = forms.CharField(
        max_length=150,
        required=True,
        label='Имя',
        widget=forms.TextInput(attrs={'class': 'form-input', 'autocomplete': 'given-name'}),
    )
    last_name = forms.CharField(
        max_length=150,
        required=True,
        label='Фамилия',
        widget=forms.TextInput(attrs={'class': 'form-input', 'autocomplete': 'family-name'}),
    )
    email = forms.EmailField(
        required=True,
        label='Email',
        widget=forms.EmailInput(attrs={'class': 'form-input', 'autocomplete': 'email'}),
    )
    username = forms.CharField(
        max_length=150,
        label='Логин',
        widget=forms.TextInput(attrs={'class': 'form-input', 'autocomplete': 'username'}),
    )
    student_number = forms.CharField(
        max_length=50,
        required=False,
        label='Номер студента',
        widget=forms.TextInput(attrs={'class': 'form-input'}),
    )

    def __init__(self, *args, user=None, **kwargs):
        super().__init__(*args, **kwargs)
        self.user = user

    def clean_username(self):
        username = self.cleaned_data.get('username', '').strip()
        if not username:
            return username
        qs = User.objects.filter(username=username)
        if self.user:
            qs = qs.exclude(pk=self.user.pk)
        if qs.exists():
            raise forms.ValidationError('Пользователь с таким логином уже существует.')
        return username


class RegistrationForm(UserCreationForm):
    first_name = forms.CharField(
        max_length=150,
        required=True,
        label='Имя',
        widget=forms.TextInput(attrs={
            'class': 'form-input',
            'placeholder': 'Ваше имя',
            'autocomplete': 'given-name',
        }),
    )
    last_name = forms.CharField(
        max_length=150,
        required=True,
        label='Фамилия',
        widget=forms.TextInput(attrs={
            'class': 'form-input',
            'placeholder': 'Ваша фамилия',
            'autocomplete': 'family-name',
        }),
    )
    username = forms.CharField(
        max_length=150,
        label='Логин',
        widget=forms.TextInput(attrs={
            'class': 'form-input',
            'placeholder': 'Придумайте логин',
            'autocomplete': 'username',
        }),
    )
    email = forms.EmailField(
        required=True,
        label='Email',
        widget=forms.EmailInput(attrs={
            'class': 'form-input',
            'placeholder': 'example@mail.ru',
            'autocomplete': 'email',
        }),
    )
    student_number = forms.CharField(
        max_length=50,
        required=False,
        label='Номер студента',
        widget=forms.TextInput(attrs={
            'class': 'form-input',
            'placeholder': 'Номер студенческого билета',
        }),
    )
    password1 = forms.CharField(
        label='Пароль',
        widget=forms.PasswordInput(attrs={
            'class': 'form-input',
            'placeholder': 'Придумайте пароль',
            'autocomplete': 'new-password',
        }),
    )
    password2 = forms.CharField(
        label='Повторите пароль',
        widget=forms.PasswordInput(attrs={
            'class': 'form-input',
            'placeholder': 'Повторите пароль',
            'autocomplete': 'new-password',
        }),
    )

    class Meta:
        model = User
        fields = ('first_name', 'last_name', 'username', 'email', 'password1', 'password2')

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['password1'].help_text = None
        self.fields['password2'].help_text = None

    def save(self, commit=True):
        user = super().save(commit=False)
        user.email = self.cleaned_data['email']
        user.first_name = self.cleaned_data['first_name']
        user.last_name = self.cleaned_data['last_name']
        if commit:
            user.save()
            student_number = self.cleaned_data.get('student_number', '')
            Profile.objects.create(
                user=user,
                role=Role.STUDENT,
                student_number=student_number,
            )
        return user


class PasswordChangeFormStyled(PasswordChangeForm):
    old_password = forms.CharField(
        label='Текущий пароль',
        widget=forms.PasswordInput(attrs={
            'class': 'form-input',
            'autocomplete': 'current-password',
        }),
    )
    new_password1 = forms.CharField(
        label='Новый пароль',
        widget=forms.PasswordInput(attrs={
            'class': 'form-input',
            'autocomplete': 'new-password',
        }),
    )
    new_password2 = forms.CharField(
        label='Повторите новый пароль',
        widget=forms.PasswordInput(attrs={
            'class': 'form-input',
            'autocomplete': 'new-password',
        }),
    )

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['new_password1'].help_text = None


class LoginForm(AuthenticationForm):
    username = forms.CharField(
        label='Email или логин',
        widget=forms.TextInput(attrs={
            'class': 'form-input',
            'placeholder': 'Введите email или логин',
            'autocomplete': 'username',
        }),
    )
    password = forms.CharField(
        label='Пароль',
        widget=forms.PasswordInput(attrs={
            'class': 'form-input',
            'placeholder': 'Введите пароль',
            'autocomplete': 'current-password',
        }),
    )
