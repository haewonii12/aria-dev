
from django.contrib import admin
from simple_history.admin import SimpleHistoryAdmin
from .models import Service

admin.site.register(Service, SimpleHistoryAdmin)