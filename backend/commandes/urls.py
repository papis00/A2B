"""
URL configuration for backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
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
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ConstructorViewSet, translate_command, deploy_commands

router = DefaultRouter()
router.register(r'constructors', ConstructorViewSet, basename='constructor')

urlpatterns = [
    path('', include(router.urls)),
    path('translate/', translate_command, name='translate-command'),
    path('deploy/', deploy_commands, name='deploy_commands'),
]
