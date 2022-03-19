import { ensureAuthenticated, Router } from '@sms/plasma-nodejs-api';

import { login, parameters, refreshToken, authorize } from '../controllers/authController';

const authRouter = Router();

authRouter.post('/login', login);
authRouter.get('/parameters', parameters);
authRouter.post('/refreshToken', refreshToken);

authRouter.use(ensureAuthenticated);

authRouter.post('/authorize', authorize);

export default authRouter;
