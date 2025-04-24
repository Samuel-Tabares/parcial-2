FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /code

# Install dependencies
COPY requirements.txt /code/
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . /code/

# Run migrations and create superuser
RUN python manage.py migrate
RUN echo "from django.contrib.auth.models import User, Group; User.objects.create_superuser('admin', 'admin@example.com', 'admin') if not User.objects.filter(username='admin').exists() else None; Group.objects.get_or_create(name='USER'); Group.objects.get_or_create(name='ADMIN'); User.objects.get(username='admin').groups.add(Group.objects.get(name='ADMIN'))" | python manage.py shell

# Run server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# Expose port
EXPOSE 8000