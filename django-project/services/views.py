# services/views.py
from django.shortcuts import render, redirect
from .models import Service
from .forms import ServiceForm

def service_list(request):
    services = Service.objects.all().order_by('-created_at')
    return render(request, 'services/service_list.html', {'services': services})

def service_create(request):
    if request.method == 'POST':
        form = ServiceForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('service_list')
    else:
        form = ServiceForm()
    return render(request, 'services/service_form.html', {'form': form})