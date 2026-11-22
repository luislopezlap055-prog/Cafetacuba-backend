-- Datos iniciales de Café Tacuba
-- Fuente: cartilla.js del frontend.
-- Carga 4 categorías y 18 productos.
-- Las imágenes NO se guardan dentro de PostgreSQL: el campo "imagen"
-- contiene la ruta relativa original, por ejemplo: img/americano.webp.
-- Los archivos de imagen deben estar disponibles en el frontend/backend
-- para que el navegador pueda mostrarlos.

BEGIN;

-- Categorías: se insertan solo si todavía no existen.
INSERT INTO categorias (nombre)
SELECT datos.nombre
FROM (VALUES
    ('Cafés calientes'),
    ('Bebidas frías'),
    ('Infusiones y té'),
    ('Dulces y postres')
) AS datos(nombre)
WHERE NOT EXISTS (
    SELECT 1
    FROM categorias c
    WHERE c.nombre = datos.nombre
);

-- Productos: se insertan solo si todavía no existe el mismo nombre
-- asociado a la misma categoría. No se borran datos existentes.

INSERT INTO productos (nombre, descripcion, imagen, precio, contiene, categoria_id)
SELECT
    datos.nombre,
    datos.descripcion,
    datos.imagen,
    datos.precio,
    datos.contiene,
    c.id
FROM (VALUES
    (
        'Espresso',
        'Café intenso y aromático',
        'img/americano.webp',
        1500.00,
        E'Café molido fresco\nAgua filtrada\nTaza pequeña\nAroma intenso\nCuerpo fuerte',
        'Cafés calientes'
    ),
    (
        'Latte',
        'Espresso con leche vaporizada',
        'img/latte.webp',
        2200.00,
        E'Espresso\nLeche vaporizada\nEspuma ligera\nTaza grande\nOpcional: arte latte',
        'Cafés calientes'
    ),
    (
        'Cappuccino',
        'Espresso, leche espumosa y cacao',
        'img/cappuccino.webp',
        2400.00,
        E'Espresso\nLeche vaporizada\nEspuma abundante\nCacao en polvo\nTaza mediana',
        'Cafés calientes'
    ),
    (
        'Mocha',
        'Espresso, chocolate y leche',
        'img/cafe_mocha.jpg',
        2700.00,
        E'Espresso\nChocolate derretido\nLeche vaporizada\nCrema opcional\nCacao espolvoreado',
        'Cafés calientes'
    ),
    (
        'Macchiato',
        'Espresso con un toque de leche espumada',
        'img/macchiato.jpeg',
        2100.00,
        E'Espresso\nEspuma de leche\nTaza pequeña\nSabor intenso\nToque cremoso',
        'Cafés calientes'
    ),
    (
        'Affogato',
        'Helado bañado en espresso caliente',
        'img/affogato.jpg',
        2800.00,
        E'Helado de vainilla\nEspresso caliente\nTaza o copa de postre\nTextura cremosa\nContraste frío-caliente',
        'Bebidas frías'
    ),
    (
        'Iced Latte',
        'Latte con hielo y leche fría',
        'img/icedLatte.jpeg',
        2500.00,
        E'Espresso\nLeche fría\nCubos de hielo\nVaso alto\nSabor suave y refrescante',
        'Bebidas frías'
    ),
    (
        'Cold Brew',
        'Extracción en frío 12 horas',
        'img/cafe.JPG',
        2600.00,
        E'Café molido grueso\nAgua filtrada fría\nProceso de 12 horas\nVaso con hielo\nSabor menos ácido',
        'Bebidas frías'
    ),
    (
        'Frappé de cacao',
        'Hielo, cacao y crema batida',
        'img/Frappé de cacao.jpeg',
        3000.00,
        E'Cubos de hielo\nCacao en polvo\nLeche fría\nCrema batida\nTextura espesa y dulce',
        'Bebidas frías'
    ),
    (
        'Té negro de la casa',
        'Con opción de leche o limón',
        'img/teNegro.jpeg',
        1800.00,
        E'Hojas de té negro\nAgua caliente\nOpción de leche\nRodaja de limón\nTaza mediana',
        'Infusiones y té'
    ),
    (
        'Té verde',
        'Suave y refrescante',
        'img/teverde.jpeg',
        1800.00,
        E'Hojas de té verde\nAgua caliente\nTaza pequeña\nAroma herbal\nSabor ligero',
        'Infusiones y té'
    ),
    (
        'Infusión de jazmín',
        'Floral y delicada',
        'img/tedejazmin.jpeg',
        2000.00,
        E'Flores de jazmín\nAgua caliente\nTaza de porcelana\nAroma floral\nSabor delicado',
        'Infusiones y té'
    ),
    (
        'Submarino',
        'Cacao a la taza con leche',
        'img/submarino.jpeg',
        2200.00,
        E'Tableta de chocolate\nLeche caliente\nTaza grande\nSabor intenso\nTextura cremosa',
        'Infusiones y té'
    ),
    (
        'Medialuna',
        'Recién horneada',
        'img/medialuna.jpeg',
        900.00,
        E'Harina de trigo\nManteca\nAzúcar\nLevadura\nGlaseado ligero',
        'Dulces y postres'
    ),
    (
        'Brownie',
        'Con nueces y chocolate fundido',
        'img/brownie.jpg',
        2300.00,
        E'Chocolate amargo\nManteca\nAzúcar\nHuevos\nNueces picadas',
        'Dulces y postres'
    ),
    (
        'Lemon Pie',
        'Tarta de limón con merengue',
        'img/Lemon Pie.jpeg',
        2500.00,
        E'Base de masa\nCrema de limón\nAzúcar\nHuevos\nMerengue italiano',
        'Dulces y postres'
    ),
    (
        'Cheesecake',
        'Con salsa de frutos rojos',
        'img/Cheesecake.jpeg',
        2800.00,
        E'Queso crema\nBase de galletas\nAzúcar\nHuevos\nSalsa de frutos rojos',
        'Dulces y postres'
    ),
    (
        'Alfajor de maicena',
        'Clásico, con dulce de leche',
        'img/Alfajor de maicena.jpeg',
        1200.00,
        E'Maicena\nHarina\nManteca\nDulce de leche\nCoco rallado',
        'Dulces y postres'
    )
) AS datos(nombre, descripcion, imagen, precio, contiene, categoria_nombre)
JOIN categorias c ON c.nombre = datos.categoria_nombre
WHERE NOT EXISTS (
    SELECT 1
    FROM productos p
    WHERE p.nombre = datos.nombre
      AND p.categoria_id = c.id
);

COMMIT;

-- Comprobación de cantidades cargadas:
SELECT c.nombre AS categoria, COUNT(p.id) AS cantidad_productos
FROM categorias c
LEFT JOIN productos p ON p.categoria_id = c.id
WHERE c.nombre IN (
    'Cafés calientes',
    'Bebidas frías',
    'Infusiones y té',
    'Dulces y postres'
)
GROUP BY c.id, c.nombre
ORDER BY c.id;
