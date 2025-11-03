# Sistema de Gestión de Pedidos

## Descripción
Este proyecto implementa un sistema de gestión integral para revendedores, que permite administrar pedidos, clientes, y productos. El sistema está construido con una arquitectura moderna de microservicios, separando el frontend del backend para mayor flexibilidad y escalabilidad.

## Estructura del Proyecto
```
proyecto/
├── backend/
│   ├── docker-compose.yml
│   ├── requirements.txt
│   └── app/
│       ├── database.py
│       ├── main.py
│       ├── models.py
│       ├── schemas.py
│       ├── crud/
│       │   ├── admins.py
│       │   ├── clients.py
│       │   ├── orders.py
│       │   └── products.py
│       └── routers/
│           ├── admins_router.py
│           ├── clients_router.py
│           ├── orders_router.py
│           └── products_router.py
├── db/
│   └── init.sql
└── frontend/
    ├── index.html
    ├── scripts/
    │   └── logic.js
    └── styles/
        └── styles.css
```

## Tecnologías Utilizadas
- **Backend**: FastAPI (Python)
- **Frontend**: HTML, CSS, JavaScript
- **Base de Datos**: PostgreSQL
- **Contenedorización**: Docker

## Funcionalidades Principales
- Gestión de clientes
- Gestión de pedidos
- Gestión de productos
- Interfaz web intuitiva
- API RESTful

## Componentes del Sistema

### Backend (FastAPI)
- Implementación de API RESTful
- Modelos de datos y esquemas
- Operaciones CRUD para todas las entidades
- Autenticación y autorización
- Manejo de base de datos

### Frontend
- Interfaz de usuario responsive
- Gestión de estados y eventos
- Comunicación con la API
- Visualización de datos

### Base de Datos
- Esquema relacional
- Inicialización automática
- Persistencia de datos

## Configuración del Proyecto

### Requisitos Previos
- Docker y Docker Compose
- Python 3.8+
- Node.js

### Instalación y Ejecución
1. Clonar el repositorio:
```bash
git clone https://github.com/tobiasvidela/FINAL.git
cd FINAL
```

2. Iniciar los servicios con Docker Compose:
```bash
cd backend
docker-compose up -d
```

3. Acceder a la aplicación:
- Frontend: http://localhost:80
- API Documentation: http://localhost:8000/docs

## Documentación
La documentación detallada de la API está disponible en la ruta `/docs` del servidor backend.

## Contribución
Las contribuciones son bienvenidas. Por favor, asegúrate de:
1. Hacer fork del repositorio
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit de tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

## Autores
- Tobias Videla (@tobiasvidela)
