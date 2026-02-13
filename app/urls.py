"""
URL configuration for app project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/6.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from . import views

urlpatterns = [
    path('', views.landing, name='landing'),
    path('contacts/', views.contacts, name='contacts'),
    path('about/', views.about, name='about'),
    path('advantages/', views.advantages, name='advantages'),
    path('faq/', views.faq, name='faq'),
    path('request-rules/', views.request_rules, name='request_rules'),
    path('student-guide/', views.student_guide, name='student_guide'),
    path('feedback/', views.feedback, name='feedback'),
    path('login/', views.login_view, name='site_login'),
    path('register/', views.register, name='site_register'),
    path('logout/', views.logout_view, name='site_logout'),
    path('settings/', views.settings_view, name='settings'),
    path('cabinet/', views.cabinet_view, name='cabinet'),
    path('admin-panel/', views.admin_panel, name='admin_panel'),
    path('admin-panel/users/', views.admin_users, name='admin_users'),
    path('admin-panel/statistics/', views.admin_statistics, name='admin_statistics'),
    path('admin-panel/statistics/export/', views.admin_statistics_export, name='admin_statistics_export'),
    path('admin-panel/feedback/', views.admin_feedback_list, name='admin_feedback_list'),
    path('admin/', admin.site.urls),
]
