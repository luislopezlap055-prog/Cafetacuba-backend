import { ArrayNotEmpty, IsArray, IsInt, IsNotEmpty, IsNumber, IsOptional, IsPositive, IsString } from 'class-validator';

export class CreatePedidoDto {
  @IsInt({ message: 'El ID del usuario debe ser un número entero' })
  @IsNotEmpty({ message: 'El ID del usuario es obligatorio' })
  @IsPositive({ message: 'El ID del usuario debe ser mayor a 0' })
  usuarioId: number;

  @IsArray({ message: 'Los productos deben enviarse en forma de lista' })
  @ArrayNotEmpty({ message: 'El pedido debe contener al menos un producto' })
  productos: number[];

  @IsNumber({}, { message: 'El total debe ser un número' })
  @IsPositive({ message: 'El total debe ser mayor a 0' })
  total: number;

  @IsString({ message: 'El estado debe ser un texto' })
  @IsNotEmpty({ message: 'El estado del pedido es obligatorio' })
  estado: string;
}
