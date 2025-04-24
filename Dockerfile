# Usar una imagen base oficial de Python
FROM python:3.9-slim

# Establecer variables de entorno
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos de requerimientos
COPY requirements.txt .

# Instalar dependencias del sistema y de Python
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    postgresql-client && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copiar todo el código del proyecto
COPY . .

# Recopilar archivos estáticos
RUN python manage.py collectstatic --noinput

# Establecer variables de entorno para la producción
ENV DJANGO_SETTINGS_MODULE=clientapi.settings
ENV DEBUG=False

# Exponer el puerto en el que corre la aplicación
EXPOSE 8000

# Comando para ejecutar la aplicación con gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "clientapi.wsgi:application"]