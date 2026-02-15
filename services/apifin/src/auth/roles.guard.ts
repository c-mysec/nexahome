import { CanActivate, ExecutionContext, ForbiddenException } from "@nestjs/common";

export function RequireRole(role: string) {
  return {
    canActivate(context: ExecutionContext) {
      const req = context.switchToHttp().getRequest();
      const roles =
        req.user?.resource_access?.appfin?.roles || [];

      if (!roles.includes(role)) {
        throw new ForbiddenException();
      }

      return true;
    },
  };
}
