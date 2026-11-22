
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { ConfigModule } from '@nestjs/config';
import { AppService } from './app.service';
import { UsuariosModule } from '../../usuarios/usuarios.module';
import { ProductosModule } from '../../productos/productos.module';
import { CategoriasModule } from '../../categorias/categorias.module';
import { PedidosModule } from '../../pedidos/pedidos.module';
import { AuthModule } from '../Auth/auth.module';
import { PrismaModule } from '../../prisma/prisma.module';
@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    PrismaModule,
    UsuariosModule,
    ProductosModule,
    CategoriasModule,
    PedidosModule,
    AuthModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}