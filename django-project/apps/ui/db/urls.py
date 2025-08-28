from django.urls import path
from . import views

urlpatterns = [
    path('', views.db_list, name='db_list'),
    path('create/', views.db_create, name='db_create'),
    # path('delete/<int:pk>/', views.db_delete, name= 'db_delete'),
]