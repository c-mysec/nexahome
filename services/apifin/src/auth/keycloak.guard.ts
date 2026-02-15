import {
    CanActivate,
    ExecutionContext,
    Injectable,
    UnauthorizedException,
  } from '@nestjs/common';
  import { jwtVerify, createRemoteJWKSet } from 'jose';
  import { Request } from 'express';
  
  const JWKS = createRemoteJWKSet(
    new URL(
        'http://keycloak:8080/realms/appfin/protocol/openid-connect/certs'
      //'https://auth.nexahome.win/realms/appfin/protocol/openid-connect/certs'
    )
  );
  
  @Injectable()
  export class KeycloakGuard implements CanActivate {
    async canActivate(context: ExecutionContext): Promise<boolean> {
      const req = context.switchToHttp().getRequest<Request>();
      const authHeader = req.headers.authorization;
  
      if (!authHeader) {
        throw new UnauthorizedException('Missing Authorization header');
      }
  
      const token = authHeader.split(' ')[1];
  
      try {
        const { payload } = await jwtVerify(token, JWKS, {
          issuer: 'https://auth.nexahome.win/realms/appfin',
          audience: ['appfin'],
        });
  
        (req as any).user = payload;
        return true;
      } catch (err: any) {
        console.error('JWT VERIFY ERROR:', err.code, err.message);
        throw new UnauthorizedException('Invalid token');
      }
    }
  }
  