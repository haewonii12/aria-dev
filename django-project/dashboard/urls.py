# dashboard/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('summary/', views.summary, name='summary'),
    path('summary/', views.summary, name='dashboard_summary'),
]