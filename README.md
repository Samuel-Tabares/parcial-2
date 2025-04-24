# Client Management API

A RESTful API built with Django and Django REST Framework for managing clients with JWT authentication.

## Features

- User registration and authentication with JWT
- Client CRUD operations
- Role-based access control (USER and ADMIN roles)
- Secure API endpoints

## Tech Stack

- Django 4.x
- Django REST Framework
- Simple JWT for authentication
- SQLite (development) / PostgreSQL (production)
- Docker (optional)

## Getting Started

### Prerequisites

- Python 3.8+
- pip

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd clientapi
   ```

2. Create a virtual environment and activate it:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install the dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Apply migrations:
   ```bash
   python manage.py migrate
   ```

5. Create admin user and groups:
   ```bash
   python manage.py shell
   ```
   
   In the shell:
   ```python
   from django.contrib.auth.models import User, Group
   # Create admin user
   user = User.objects.create_superuser('admin', 'admin@example.com', 'admin')
   # Create groups
   Group.objects.get_or_create(name='USER')
   Group.objects.get_or_create(name='ADMIN')
   # Add admin to ADMIN group
   user.groups.add(Group.objects.get(name='ADMIN'))
   exit()
   ```

6. Run the development server:
   ```bash
   python manage.py runserver
   ```

### Docker (Optional)

You can also run the application using Docker:

```bash
docker build -t clientapi .
docker run -p 8000:8000 clientapi
```

## API Endpoints

### Authentication

- `POST /api/auth/register/`: Register a new user
- `POST /api/auth/login/`: Login and obtain JWT tokens
- `POST /api/auth/refresh/`: Refresh JWT token

### Client Management

- `GET /api/clients/`: List all clients (ADMIN only)
- `POST /api/clients/`: Create a new client
- `GET /api/clients/{id}/`: Retrieve a client (owner or ADMIN)
- `PUT /api/clients/{id}/`: Update a client (owner or ADMIN)
- `DELETE /api/clients/{id}/`: Delete a client (ADMIN only)

## Example API Usage

### Register a User

```bash
curl -X POST http://localhost:8000/api/auth/register/ \
  -H "Content-Type: application/json" \
  -d '{
    "username": "user1",
    "password": "StrongPassword123!",
    "password2": "StrongPassword123!",
    "email": "user1@example.com",
    "first_name": "John",
    "last_name": "Doe"
  }'
```

### Login

```bash
curl -X POST http://localhost:8000/api/auth/login/ \
  -H "Content-Type: application/json" \
  -d '{
    "username": "user1",
    "password": "StrongPassword123!"
  }'
```

Response:
```json
{
  "refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
  "access": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
}
```

### Create a Client

```bash
curl -X POST http://localhost:8000/api/clients/ \
  -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..." \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Client Company",
    "email": "client@example.com",
    "phone": "123-456-7890",
    "address": "123 Main St, Anytown, USA"
  }'
```

### Get All Clients (ADMIN only)

```bash
curl -X GET http://localhost:8000/api/clients/ \
  -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
```

### Get a Specific Client

```bash
curl -X GET http://localhost:8000/api/clients/1/ \
  -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
```

### Update a Client

```bash
curl -X PUT http://localhost:8000/api/clients/1/ \
  -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..." \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Updated Client Name",
    "email": "client@example.com",
    "phone": "123-456-7890",
    "address": "123 Main St, Anytown, USA"
  }'
```

### Delete a Client (ADMIN only)

```bash
curl -X DELETE http://localhost:8000/api/clients/1/ \
  -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
```

## Deployment

This API can be deployed to platforms like:
- Railway.app
- Heroku
- Render

### Railway.app Example

1. Push your code to GitHub
2. Connect your GitHub repository to Railway
3. Add environment variables as needed
4. Deploy the project

## License

This project is licensed under the MIT License.