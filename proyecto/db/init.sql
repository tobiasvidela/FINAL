-- init.sql
-- Base de datos PostgreSQL para sistema de pedidos - Tobías Videla Guliotti

CREATE SCHEMA IF NOT EXISTS app;

-- Tipos de datos
CREATE TYPE app.client_type AS ENUM ('minorista', 'mayorista');
CREATE TYPE app.order_status AS ENUM ('nuevo','en_preparacion','en_envio','completado','cancelado');
CREATE TYPE app.stock_movement_type AS ENUM ('entrada','salida','ajuste');

-- Tabla de clientes
CREATE TABLE app.clients (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    telefono VARCHAR(50),
    direccion TEXT,
    tipo_cliente app.client_type DEFAULT 'minorista',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- Tabla de administradores (separada de clientes)
CREATE TABLE app.admins (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    telefono VARCHAR(50),
    is_superadmin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- Proveedores
CREATE TABLE app.suppliers (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    telefono VARCHAR(50),
    email VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Categorías
CREATE TABLE app.categories (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT
);

-- Productos
CREATE TABLE app.products (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    origen VARCHAR(200),
    productor VARCHAR(200),
    peso_kg NUMERIC(8,3),
    descripcion TEXT,
    precio_compra NUMERIC(12,2),
    precio_minorista NUMERIC(12,2),
    precio_mayorista NUMERIC(12,2),
    precio_por_kilo NUMERIC(12,2),
    cantidad_stock INTEGER DEFAULT 0,
    category_id BIGINT REFERENCES app.categories(id) ON DELETE SET NULL,
    supplier_id BIGINT REFERENCES app.suppliers(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- Historial de stock
CREATE TABLE app.stock_movements (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id BIGINT NOT NULL REFERENCES app.products(id) ON DELETE CASCADE,
    tipo app.stock_movement_type NOT NULL,
    cantidad INTEGER NOT NULL,
    descripcion TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Carritos
CREATE TABLE app.carts (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    client_id BIGINT UNIQUE NOT NULL REFERENCES app.clients(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE app.cart_items (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cart_id BIGINT NOT NULL REFERENCES app.carts(id) ON DELETE CASCADE,
    product_id BIGINT NOT NULL REFERENCES app.products(id),
    cantidad INTEGER NOT NULL DEFAULT 1,
    precio_unitario NUMERIC(12,2)
);

-- Pedidos
CREATE TABLE app.orders (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    client_id BIGINT NOT NULL REFERENCES app.clients(id) ON DELETE CASCADE,
    admin_id BIGINT REFERENCES app.admins(id),
    status app.order_status DEFAULT 'nuevo',
    total NUMERIC(14,2) DEFAULT 0,
    direccion_envio TEXT,
    telefono_contacto VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE app.order_items (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL REFERENCES app.orders(id) ON DELETE CASCADE,
    product_id BIGINT NOT NULL REFERENCES app.products(id),
    cantidad INTEGER NOT NULL,
    precio_unitario NUMERIC(12,2)
);

-- Logs de pedidos (historial de eventos)
CREATE TABLE app.order_logs (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL REFERENCES app.orders(id) ON DELETE CASCADE,
    evento VARCHAR(255) NOT NULL,
    descripcion TEXT,
    creado_por VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Índices
CREATE INDEX idx_products_supplier ON app.products(supplier_id);
CREATE INDEX idx_orders_client ON app.orders(client_id);
CREATE INDEX idx_orders_status ON app.orders(status);
