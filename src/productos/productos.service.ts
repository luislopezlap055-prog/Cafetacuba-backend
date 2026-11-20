import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateProductoDto } from './dto/create-producto.dto';
import { UpdateProductoDto } from './dto/update-producto.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ProductosService {
  constructor(private readonly prisma: PrismaService) {}

  create(createProductoDto: CreateProductoDto) {
    return this.prisma.productos.create({
      data: createProductoDto,
    });
  }

  findAll() {
    return this.prisma.productos.findMany({
      include: {
        categorias: true,
      },
    });
  }

  async findOne(id: number) {
    const producto = await this.prisma.productos.findUnique({
      where: { id },
      include: {
        categorias: true,
      },
    });
    if (!producto) {
      throw new NotFoundException('Producto no encontrado');
    }
    return producto;
  }

  async update(id: number, updateProductoDto: UpdateProductoDto) {
    await this.findOne(id);
    return this.prisma.productos.update({
      where: { id },
      data: updateProductoDto,
    });
  }

  async remove(id: number) {
    await this.findOne(id);
    await this.prisma.productos.delete({
      where: { id },
    });
    return { mensaje: 'Producto eliminado correctamente' };
  }
}

