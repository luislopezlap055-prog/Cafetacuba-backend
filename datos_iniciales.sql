-- CAFE TACUBA - DATOS COMPLETOS PARA POSTGRESQL
-- Ejecutar DESPUES de las migraciones de Prisma sobre la base cafetacuba.
-- No crea ni elimina tablas. No contiene DROP TABLE.
-- Conserva los 18 productos del SQL original y agrega la quinta categoria.
-- Incluye 5 usuarios y 5 pedidos de prueba.
-- Clave de los usuarios de prueba: 123456 (guardada mediante bcrypt).

BEGIN;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO categorias (id, nombre)
VALUES
  (1, 'Cafés calientes'),
  (2, 'Bebidas frías'),
  (3, 'Infusiones y té'),
  (4, 'Dulces y postres'),
  (5, 'Otros')
ON CONFLICT (id) DO NOTHING;

INSERT INTO productos
  (id, nombre, descripcion, imagen, precio, contiene, categoria_id)
VALUES
  (28, 'Espresso', 'Café intenso y aromático', 'img/americano.webp', 1500.00, '"Café molido fresco", "Agua filtrada", "Taza pequeña", "Aroma intenso", "Cuerpo fuerte"', 1),
  (29, 'Latte', 'Espresso con leche vaporizada', 'img/latte.webp', 2200.00, '"Espresso", "Leche vaporizada", "Espuma ligera", "Taza grande", "Opcional: arte latte"', 1),
  (30, 'Cappuccino', 'Espresso, leche espumosa y cacao', 'img/cappuccino.webp', 2400.00, '"Espresso", "Leche vaporizada", "Espuma abundante", "Cacao en polvo", "Taza mediana"', 1),
  (31, 'Mocha', 'Espresso, chocolate y leche', 'img/cafe_mocha.jpg', 2700.00, '"Espresso", "Chocolate derretido", "Leche vaporizada", "Crema opcional", "Cacao espolvoreado"', 1),
  (32, 'Macchiato', 'Espresso con un toque de leche espumada', 'img/macchiato.jpeg', 2100.00, '"Espresso", "Espuma de leche", "Taza pequeña", "Sabor intenso", "Toque cremoso"', 1),
  (33, 'Affogato', 'Helado bañado en espresso caliente', 'img/affogato.jpg', 2800.00, '"Helado de vainilla", "Espresso caliente", "Taza o copa de postre", "Textura cremosa", "Contraste frío-caliente"', 2),
  (34, 'Iced Latte', 'Latte con hielo y leche fría', 'img/icedLatte.jpeg', 2500.00, '"Espresso", "Leche fría", "Cubos de hielo", "Vaso alto", "Sabor suave y refrescante"', 2),
  (35, 'Cold Brew', 'Extracción en frío 12 horas', 'img/cafe.JPG', 2600.00, '"Café molido grueso", "Agua filtrada fría", "Proceso de 12 horas", "Vaso con hielo", "Sabor menos ácido"', 2),
  (36, 'Frappé de cacao', 'Hielo, cacao y crema batida', 'img/Frappé de cacao.jpeg', 3000.00, '"Cubos de hielo", "Cacao en polvo", "Leche fría", "Crema batida", "Textura espesa y dulce"', 2),
  (37, 'Té negro de la casa', 'Con opción de leche o limón', 'img/teNegro.jpeg', 1800.00, '"Hojas de té negro", "Agua caliente", "Opción de leche", "Rodaja de limón", "Taza mediana"', 3),
  (38, 'Té verde', 'Suave y refrescante', 'img/teverde.jpeg', 1800.00, '"Hojas de té verde", "Agua caliente", "Taza pequeña", "Aroma herbal", "Sabor ligero"', 3),
  (39, 'Infusión de jazmín', 'Floral y delicada', 'img/tedejazmin.jpeg', 2000.00, '"Flores de jazmín", "Agua caliente", "Taza de porcelana", "Aroma floral", "Sabor delicado"', 3),
  (40, 'Submarino', 'Cacao a la taza con leche', 'img/submarino.jpeg', 2200.00, '"Tableta de chocolate", "Leche caliente", "Taza grande", "Sabor intenso", "Textura cremosa"', 3),
  (41, 'Medialuna', 'Recién horneada', 'img/medialuna.jpeg', 900.00, '"Harina de trigo", "Manteca", "Azúcar", "Levadura", "Glaseado ligero"', 4),
  (42, 'Brownie', 'Con nueces y chocolate fundido', 'img/brownie.jpg', 2300.00, '"Chocolate amargo", "Manteca", "Azúcar", "Huevos", "Nueces picadas"', 4),
  (43, 'Lemon Pie', 'Tarta de limón con merengue', 'img/Lemon Pie.jpeg', 2500.00, '"Base de masa", "Crema de limón", "Azúcar", "Huevos", "Merengue italiano"', 4),
  (44, 'Cheesecake', 'Con salsa de frutos rojos', 'img/Cheesecake.jpeg', 2800.00, '"Queso crema", "Base de galletas", "Azúcar", "Huevos", "Salsa de frutos rojos"', 4),
  (45, 'Alfajor de maicena', 'Clásico, con dulce de leche', 'img/Alfajor de maicena.jpeg', 1200.00, '"Maicena", "Harina", "Manteca", "Dulce de leche", "Coco rallado"', 4)
ON CONFLICT (id) DO NOTHING;

INSERT INTO usuarios (id, nombre, email, password)
VALUES
  (1, 'Usuario de prueba 1', 'usuario1@cafetacuba.test', crypt('123456', gen_salt('bf'))),
  (2, 'Usuario de prueba 2', 'usuario2@cafetacuba.test', crypt('123456', gen_salt('bf'))),
  (3, 'Usuario de prueba 3', 'usuario3@cafetacuba.test', crypt('123456', gen_salt('bf'))),
  (4, 'Usuario de prueba 4', 'usuario4@cafetacuba.test', crypt('123456', gen_salt('bf'))),
  (5, 'Usuario de prueba 5', 'usuario5@cafetacuba.test', crypt('123456', gen_salt('bf')))
ON CONFLICT (id) DO NOTHING;

INSERT INTO pedidos (id, "usuarioId", productos, total, estado)
VALUES
  (1, 1, ARRAY[28, 29]::integer[], 3700.00, 'Pendiente'),
  (2, 2, ARRAY[30]::integer[], 2400.00, 'Confirmado'),
  (3, 3, ARRAY[41, 42]::integer[], 3200.00, 'Entregado'),
  (4, 4, ARRAY[34]::integer[], 2500.00, 'Pendiente'),
  (5, 5, ARRAY[43, 44]::integer[], 5300.00, 'Confirmado')
ON CONFLICT (id) DO NOTHING;

SELECT setval(pg_get_serial_sequence('categorias', 'id'), GREATEST(COALESCE((SELECT MAX(id) FROM categorias), 1), 1), EXISTS (SELECT 1 FROM categorias));
SELECT setval(pg_get_serial_sequence('productos', 'id'), GREATEST(COALESCE((SELECT MAX(id) FROM productos), 1), 1), EXISTS (SELECT 1 FROM productos));
SELECT setval(pg_get_serial_sequence('usuarios', 'id'), GREATEST(COALESCE((SELECT MAX(id) FROM usuarios), 1), 1), EXISTS (SELECT 1 FROM usuarios));
SELECT setval(pg_get_serial_sequence('pedidos', 'id'), GREATEST(COALESCE((SELECT MAX(id) FROM pedidos), 1), 1), EXISTS (SELECT 1 FROM pedidos));

COMMIT;

SELECT 'categorias' AS tabla, COUNT(*) AS registros FROM categorias
UNION ALL SELECT 'productos', COUNT(*) FROM productos
UNION ALL SELECT 'usuarios', COUNT(*) FROM usuarios
UNION ALL SELECT 'pedidos', COUNT(*) FROM pedidos;
