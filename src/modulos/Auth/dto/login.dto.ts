import { IsEmail, IsNotEmpty, MinLength} from 'class-validator';

export class LoginDto {

  @IsEmail({}, { message: 'Email inválido' })
  @IsEmail({}, { message: 'El correo electrónico debe tener un formato válido.' })
  email: string;

  @IsNotEmpty({ message: 'La contraseña es obligatoria.' })
  @MinLength(8, {message: 'La contraseña debe tener al menos 8 caracteres.',})
  password: string;
}
