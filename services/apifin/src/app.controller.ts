import { Controller, Get, Req, UseGuards } from '@nestjs/common';
import { AppService } from './app.service';
import * as pkg from '../package.json';
import { KeycloakGuard } from './auth/keycloak.guard';
import { RequireRole } from './auth/roles.guard';
import { Request } from "express";

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('health')
  health() {
    return {
      status: 'ok',
      service: 'apifin',
      timestamp: new Date().toISOString(),
    };
  }

  @Get('version')
  version() {
    return {
      service: 'apifin',
      version: pkg.version,
      environment: process.env.NODE_ENV || 'development',
      timestamp: new Date().toISOString(),
    };
  }

  @UseGuards(KeycloakGuard)
  @Get("/admin")
  @UseGuards(RequireRole("admin"))
  getAdminData() {
    return { secret: "admin-only" };
  }

  @Get("/me")
  @UseGuards(KeycloakGuard)
  me(@Req() req: Request) {
    return {
      sub: (req as any).user.sub,
      username: (req as any).user.preferred_username,
    };
  }
}

