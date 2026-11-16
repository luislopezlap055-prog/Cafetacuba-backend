import { IsInt, IsNotEmpty, IsNumber, IsPositive, IsString, MaxLength } from 'class-validator';

export class CreateProductoDto {
  @IsString({ message: 'El nombre debe ser un texto' })
  @IsNotEmpty({ message: 'El nombre es obligatorio' })
  @MaxLength(100)
  nombre: string;

  @IsString({ message: 'La descripción debe ser un texto' })
  @IsNotEmpty({ message: 'La descripción es obligatoria' })
  @MaxLength(255)
  descripcion: string;

  @IsString({ message: 'La imagen debe ser un texto con la ruta' })
  @IsNotEmpty({ message: 'La imagen es obligatoria' })
  @MaxLength(255)
  imagen: string;

  @IsNumber({}, { message: 'El precio debe ser un número' })
  @IsPositive({ message: 'El precio debe ser mayor a 0' })
  precio: number;

  @IsString({ message: 'El campo contiene debe ser un texto' })
  @IsNotEmpty({ message: 'Los ingredientes o detalles son obligatorios' })
  contiene: string;

  @IsInt({ message: 'El ID de categoría debe ser un número entero' })
  @IsPositive({ message: 'El ID de categoría debe ser válido' })
  categoria_id: number;
}
