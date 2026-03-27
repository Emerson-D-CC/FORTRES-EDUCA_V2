helpdesk_flask/
│
├── app/
│   │
│   ├── __init__.py*  
│   │   Inicializa la aplicación Flask usando Application Factory.
│
│   ├── extensions.py*  
│   │   Inicializa extensiones globales (mysql connector, login manager, etc).
│
│   ├── config.py  
│   │   Configuración del proyecto (dev, test, prod).
│
│   ├── database/
│   │   │
│   │   ├── connection.py*  
│   │   │   Maneja la conexión a MySQL.
│   │   │
│   │   ├── procedures.py*  
│   │   │   Centraliza llamadas a procedimientos almacenados.
│   │   │
│   │   └── migrations!*  
│   │       Se elimina porque la BD se crea externamente.
│
│   ├── core/ *
│   │   Funcionalidades globales del sistema.
│   │
│   │   ├── error_handlers.py  
│   │   │   Maneja errores 404, 500.
│   │   │
│   │   ├── security.py*  
│   │   │   Autenticación y permisos.
│   │   │
│   │   └── utils.py*  
│   │       Funciones auxiliares globales.
│
│   ├── modules/
│   │
│   │   ├── admin/
│   │   │   (similar a una app de Django)
│   │   │
│   │   │   ├── routes.py  
│   │   │   ├── service.py  
│   │   │   ├── forms.py*  
│   │   │   └── models.py*
│   │
│   │   ├── users/
│   │   │
│   │   │   ├── routes.py  
│   │   │   ├── service.py  
│   │   │   ├── forms.py*  
│   │   │   └── models.py  
│   │
│   │   ├── technicians/
│   │   │
│   │   │   ├── routes.py  
│   │   │   ├── service.py  
│   │   │   ├── forms.py*  
│   │   │   └── models.py  
│   │
│   │   ├── tickets/
│   │   │
│   │   │   ├── routes.py  
│   │   │   ├── service.py  
│   │   │   ├── forms.py*  
│   │   │   └── models.py  
│   │
│   │   └── public/
│   │       │
│   │       ├── routes.py  
│   │       └── forms.py*
│
│   ├── templates/
│   │
│   │   ├── layouts/  
│   │   │   base.html
│   │   │
│   │   ├── components/  
│   │   │   navbar.html
│   │   │   sidebar.html
│   │   │   alerts.html
│   │   │
│   │   ├── admin/
│   │   ├── technicians/
│   │   ├── users/
│   │   └── public/
│   │
│   ├── static/
│   │
│   │   ├── css/
│   │   │
│   │   ├── js/
│   │   │
│   │   └── images/
│
│   └── errors/
│       ├── templates/
│       │   ├── 404.html
│       │   └── 500.html
│       └── handlers.py
│
├── docs/
│   │
│   ├── arquitectura.md    
│   └── database/
│       └── tables.md
│       └── procedures.md
├── tests/
│   │
│   ├── test_auth.py*
│   ├── test_users.py*
│   └── test_tickets.py*
│
├── instance/ *
│   │
│   └── config.py  
│   Configuración sensible fuera del repo.
│
├── env/
│
├── run.py  
│
├── requirements.txt  
│
└── README.md*