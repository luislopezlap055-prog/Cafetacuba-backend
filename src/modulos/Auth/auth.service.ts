import {
  ConflictException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { PrismaService } from '../../prisma/prisma.service';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
  ) {}

  async register(registerDto: RegisterDto) {
    const usuarioExistente = await this.prisma.usuarios.findUnique({
      where: { email: registerDto.email },
    });

    if (usuarioExistente) {
      throw new ConflictException('El correo electrónico ya está registrado');
    }

    const passwordHash = await bcrypt.hash(registerDto.password, 10);

    const usuario = await this.prisma.usuarios.create({
      data: {
        nombre: registerDto.nombre,
        email: registerDto.email,
        password: passwordHash,
      },
      select: {
        id: true,
        nombre: true,
        email: true,
      },
    });

    return {
      mensaje: 'Usuario registrado correctamente',
      usuario,
    };
  }

  async login(loginDto: LoginDto) {
    const usuario = await this.prisma.usuarios.findUnique({
      where: { email: loginDto.email },
    });

    if (!usuario) {
      throw new UnauthorizedException('Correo o contraseña incorrectos');
    }

    const passwordValida = await bcrypt.compare(
      loginDto.password,
      usuario.password,
    );

    if (!passwordValida) {
      throw new UnauthorizedException('Correo o contraseña incorrectos');
    }

    const payload = {
      sub: usuario.id,
      email: usuario.email,
    };

    const accessToken = await this.jwtService.signAsync(payload);

    return {
      access_token: accessToken,
      usuario: {
        id: usuario.id,
        nombre: usuario.nombre,
        email: usuario.email,
      },
    };
  }
}
