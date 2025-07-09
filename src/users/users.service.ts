import { Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { PrismaService } from 'src/database/prisma.service';
//parte que é responsável pela lógica de negócios ex: crirar um usuário 

@Injectable()
export class UsersService {
  constructor(private readonly prismaService: PrismaService){}
 async create(createUserDto: CreateUserDto) {
    const user = await this.prismaService.user.create({
      data:{
        name: createUserDto.name,
        email: createUserDto.email,
        password: createUserDto.password,

      },
    })
    return user
  }

}
