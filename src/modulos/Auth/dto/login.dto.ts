feature/validaciones
import { IsEmail, IsNotEmpty, MinLength} from 'class-validator';

export class LoginDto {

  @IsEmail({}, { message: 'El correo electrónico debe tener un formato válido.' })
  email: string;

  @IsNotEmpty({ message: 'La contraseña es obligatoria.' })
import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

export class LoginDto {
  @IsEmail()
  email: string;

  @IsString()
  @IsNotEmpty()
  password: string;
}
