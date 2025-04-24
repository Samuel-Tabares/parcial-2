import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'clientapi.settings')
django.setup()

from django.contrib.auth.models import User, Group

# Crear grupos
user_group, created_user = Group.objects.get_or_create(name='USER')
admin_group, created_admin = Group.objects.get_or_create(name='ADMIN')

print(f"Grupo USER {'creado' if created_user else 'ya existe'}")
print(f"Grupo ADMIN {'creado' if created_admin else 'ya existe'}")

# Añadir el usuario admin al grupo ADMIN
try:
    admin = User.objects.get(username='admin')
    admin.groups.add(admin_group)
    print("Usuario 'admin' añadido al grupo ADMIN")
except User.DoesNotExist:
    print("El usuario 'admin' no existe")