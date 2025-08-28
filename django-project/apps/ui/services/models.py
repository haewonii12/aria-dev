from django.db import models
from simple_history.models import HistoricalRecords

class Service(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)

    history = HistoricalRecords()

    def __str__(self):
        return self.name