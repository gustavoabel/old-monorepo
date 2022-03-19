import { User } from '../../services/pgApi/user';

export interface InviteUserReqBody {
  domain: string;
  usernames: string[];
}

export interface UpdateReqParams extends Record<string, string> {
  id: string;
}

export interface ChangePasswordReqBody {
  currentPassword: string;
  newPassword: string;
}

export interface RegisterReqBody {
  first_name: string;
  last_name: string;
  username: string;
  email: string;
  password: string;
  application_code: string;
  key?: string;
}

export interface RegisterResBody {
  id: number;
}

export interface VerifyReqBody {
  key: string;
}

export interface CheckValidLinkResetPasswordReqBody {
  key: string;
}

export interface TokenParams {
  id: number;
}

export interface ForgotPasswordReqBody {
  email: string;
  application_code: string;
}

export interface ResetPasswordReqBody {
  key: string;
  password: string;
}

export type SignUpSource = (user: Partial<User>, config: Record<string, unknown> | undefined) => Promise<boolean>;

export interface CheckForSignUpReqBody {
  email: string;
  application_code: string;
}

export interface CheckForSignUpResBody {
  hasSignUp: boolean;
}

export type ChangePasswordSource = (
  password: string,
  user: Partial<User>,
  config: Record<string, unknown> | undefined,
) => Promise<boolean>;

export interface DeleteReqParams extends Record<string, string> {
  id: string;
}

export type DeleteUserSource = (user: Partial<User>, config: Record<string, unknown> | undefined) => Promise<boolean>;

export interface RequestApplicationReqBody {
  application_id: number;
  user_id: number;
}
