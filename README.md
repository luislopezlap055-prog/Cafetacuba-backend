# Café Tacuba API

Backend del proyecto Café Tacuba desarrollado con NestJS y TypeScript para la materia Programación IV.

## Tecnologías utilizadas

- NestJS
- TypeScript
- PostgreSQL
- Prisma ORM
- JWT
- bcrypt
- class-validator
- class-transformer

## Módulos

- Usuarios
- Productos
- Categorías
- Pedidos
- Auth

## Instalación

Instalar las dependencias:

```bash
npm install
```

Crear el archivo `.env` en la raíz del proyecto:

```env
PORT=4000
API_BASE_URL=http://localhost:4000
DATABASE_URL="postgresql://postgres:CONTRASEÑA@localhost:5432/cafetacuba?schema=public"
JWT_SECRET="cafetacuba_secreto_local"
```

Reemplazar `CONTRASEÑA` por la contraseña local de PostgreSQL.

## Base de datos

La base de datos utilizada es PostgreSQL y las consultas se realizan mediante Prisma ORM.

Tablas:

- `categorias`
- `productos`
- `usuarios`
- `pedidos`

La tabla productos tiene una relación con categorías. La tabla pedidos tiene una relación con usuarios.

## Prisma

Validar el esquema:

```bash
npx prisma validate
```

Generar Prisma Client:

```bash
npx prisma generate
```

Ejecutar migraciones:

```bash
npx prisma migrate dev --name init
```

## Ejecutar el proyecto

Modo desarrollo:

```bash
npm run start:dev
```

Compilar:

```bash
npm run build
```

La API se ejecuta en:

`http://localhost:4000`

## Endpoints

### Usuarios

- GET `/usuarios`
- GET `/usuarios/:id`
- PATCH `/usuarios/:id`
- DELETE `/usuarios/:id`

### Productos

- POST `/productos`
- GET `/productos`
- GET `/productos/:id`
- PATCH `/productos/:id`
- DELETE `/productos/:id`

### Categorías

- POST `/categorias`
- GET `/categorias`
- GET `/categorias/:id`
- PATCH `/categorias/:id`
- DELETE `/categorias/:id`

### Pedidos

- POST `/pedidos`
- GET `/pedidos`
- GET `/pedidos/:id`
- PATCH `/pedidos/:id`
- DELETE `/pedidos/:id`

### Autenticación

- POST `/auth/register`
- POST `/auth/login`

Las contraseñas se almacenan mediante hash bcrypt y la autenticación utiliza JWT con una duración de 24 horas.

## Seguridad

El archivo `.env` contiene datos privados de conexión y no debe subirse a GitHub.
