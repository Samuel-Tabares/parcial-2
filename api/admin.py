from django.contrib import admin
from .models import Client

# Registrar el modelo Client en el admin
@admin.register(Client)
class ClientAdmin(admin.ModelAdmin):
    list_display = ('name', 'email', 'phone', 'created_at', 'updated_at')
    search_fields = ('name', 'email')
    list_filter = ('created_at',)