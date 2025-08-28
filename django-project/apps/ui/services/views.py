from django.shortcuts import render, redirect, get_object_or_404
from .models import Service

def service_list(request):
    services = Service.objects.all()
    return render(request, 'service/service_list.html', {'services': services})

def service_create(request):
    if request.method == 'POST':
        name = request.POST['name']
        description = request.POST.get('description', '')
        is_active = bool(request.POST.get('is_active'))
        Service.objects.create(name=name, description=description, is_active=is_active)
        return redirect('service_list')
    return render(request, 'service/service_form.html')

def service_delete(request, pk):
    service = get_object_or_404(Service, pk=pk)
    service.delete()
    return redirect('service_list')