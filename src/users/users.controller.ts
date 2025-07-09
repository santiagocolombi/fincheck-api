import { Controller, Post, Body  } from '@nestjs/common';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';

//parte que vai receber as requisições
@Controller('users') //Userscontroller  é responsável pelas rotas de usuário com /users
export class UsersController {
  constructor(private readonly usersService: UsersService) {} //injeta os serviços de UsersService dentro do controller

  @Post()
  create(@Body() createUserDto: CreateUserDto) {
    
    return this.usersService.create(createUserDto);
  }

 

}
