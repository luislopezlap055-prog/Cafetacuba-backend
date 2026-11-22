import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateCategoriaDto } from './dto/create-categoria.dto';
import { UpdateCategoriaDto } from './dto/update-categoria.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class CategoriasService {
  constructor(private readonly prisma: PrismaService) {}

  create(createCategoriaDto: CreateCategoriaDto) {
    return this.prisma.categorias.create({
      data: createCategoriaDto,
    });
  }

  findAll() {
    return this.prisma.categorias.findMany({
      include: {
        productos: true,
      },
    });
  }

  async findOne(id: number) {
    const categoria = await this.prisma.categorias.findUnique({
      where: { id },
      include: {
        productos: true,
      },
    });
    if (!categoria) {
      throw new NotFoundException('Categoría no encontrada');
    }
    return categoria;
  }

  async update(id: number, updateCategoriaDto: UpdateCategoriaDto) {
    await this.findOne(id);
    return this.prisma.categorias.update({
      where: { id },
      data: updateCategoriaDto,
    });
  }

  async remove(id: number) {
    await this.findOne(id);
    await this.prisma.categorias.delete({
      where: { id },
    });
    return { mensaje: 'Categoría eliminada correctamente' };
  }
} 