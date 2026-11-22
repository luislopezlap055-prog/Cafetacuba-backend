import { Injectable, NotFoundException } from '@nestjs/common';
import { UpdateUsuarioDto } from './dto/update-usuario.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class UsuariosService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.usuarios.findMany({
      select: { id: true, nombre: true, email: true },
    });
  }

  async findOne(id: number) {
    const usuario = await this.prisma.usuarios.findUnique({
      where: { id },
      select: { id: true, nombre: true, email: true },
    });

    if (!usuario) {
      throw new NotFoundException('Usuario no encontrado');
    }

    return usuario;
  }

  async update(id: number, updateUsuarioDto: UpdateUsuarioDto) {
    await this.findOne(id);

    return this.prisma.usuarios.update({
      where: { id },
      data: updateUsuarioDto,
      select: { id: true, nombre: true, email: true },
    });
  }

  async remove(id: number) {
    await this.findOne(id);
    await this.prisma.usuarios.delete({ where: { id } });
    return { mensaje: 'Usuario eliminado correctamente' };
  }
}
