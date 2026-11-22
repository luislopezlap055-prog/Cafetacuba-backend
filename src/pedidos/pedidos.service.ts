import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreatePedidoDto } from './dto/create-pedido.dto';
import { UpdatePedidoDto } from './dto/update-pedido.dto';

@Injectable()
export class PedidosService {
  constructor(private readonly prisma: PrismaService) {}

  create(createPedidoDto: CreatePedidoDto) {
    return this.prisma.pedidos.create({
      data: {
        usuarioId: createPedidoDto.usuarioId,
        productos: createPedidoDto.productos,
        total: createPedidoDto.total,
        estado: createPedidoDto.estado,
      },
    });
  }

  findAll() {
    return this.prisma.pedidos.findMany({
      include: {
        usuario: {
          select: {
            id: true,
            nombre: true,
            email: true,
          },
        },
      },
    });
  }

  async findOne(id: number) {
    const pedido = await this.prisma.pedidos.findUnique({
      where: { id },
      include: {
        usuario: {
          select: {
            id: true,
            nombre: true,
            email: true,
          },
        },
      },
    });

    if (!pedido) {
      throw new NotFoundException('Pedido no encontrado');
    }

    return pedido;
  }

  async update(id: number, updatePedidoDto: UpdatePedidoDto) {
    await this.findOne(id);

    return this.prisma.pedidos.update({
      where: { id },
      data: updatePedidoDto,
    });
  }

  async remove(id: number) {
    await this.findOne(id);

    await this.prisma.pedidos.delete({
      where: { id },
    });

    return { mensaje: 'Pedido eliminado correctamente' };
  }
}