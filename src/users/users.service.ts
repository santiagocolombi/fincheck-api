import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { CreateUserDto } from './dto/create-user.dto';

@Injectable()
export class UsersService {
  constructor(public prisma: PrismaService) {}
  async create(createUserDto: CreateUserDto) {
    await this.prisma.users.create({ data: createUserDto });
    return createUserDto;
  }
}
