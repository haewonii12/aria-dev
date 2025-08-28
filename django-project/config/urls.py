"""
URL configuration for config project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
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
from django.urls import path, include
from django.shortcuts import redirect

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),  # API 앱 라우팅
    # path('services/', include('services.urls')),  # service routing
    path('services/', include('apps.ui.services.urls')), 
    path('db/', include('apps.ui.db.urls')), 
    path('login/', include('login.urls')),           # 로그인 기능
    path('dashboard/', include('dashboard.urls')),   # 요약 메인

    # 👉 여기 추가!
    path('', lambda request: redirect('/dashboard/summary/')),

]
