from django.shortcuts import render, redirect, get_object_or_404
# from .models import Service

def db_list(request):
    # services = Service.objects.all()
    return render(request, 'db/db_list.html')

def db_create(request):
    # if request.method == 'POST':
    #     name = request.POST['name']
    #     description = request.POST.get('description', '')
    #     is_active = bool(request.POST.get('is_active'))
    #     Service.objects.create(name=name, description=description, is_active=is_active)
    #     return redirect('service_list')
    return render(request, 'db/db_form.html')

# def service_delete(request, pk):
#     service = get_object_or_404(Service, pk=pk)
#     service.delete()
#     return redirect('service_list')