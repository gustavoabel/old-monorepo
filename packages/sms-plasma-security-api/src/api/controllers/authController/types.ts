import { PasswordPolicy } from '../../services/pgApi/pwdPolicy';

export interface LoginReqBody {
  username: string;
  password: string;
}

export interface LoginResBody {
  id: number;
  username: string;
  first_name?: string;
  last_name?: string;
  email?: string;
  is_admin: boolean;
  security: Record<string, Record<string, unknown>>;
}

interface SourceResponse {
  ok: boolean;
  data: {
    tokenExpiresIn: number;
    refreshTokenExpiresIn: number;
    token: string;
    refreshToken: string;
  };
}

export type SignInSource = (
  username: string,
  password: string,
  config: Record<string, unknown> | undefined,
  utils: unknown,
) => Promise<SourceResponse>;

export interface ParametersResBody {
  isUserDefinedByEmail: boolean;
  passwordPolicy?: PasswordPolicy[];
  parameterValues?: unknown;
}

export type RefreshSource = (token: string, config: Record<string, unknown> | undefined) => Promise<SourceResponse>;
