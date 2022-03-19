import { ensureAuthenticated, Router } from '@sms/plasma-nodejs-api';

import {
  inviteUser,
  changeUserPassword,
  registerUser,
  verifyUser,
  forgotPassword,
  resetPassword,
  checkValidLinkResetPassword,
  checkForSignUp,
  deleteUser,
  requestApplication,
} from '../controllers/userController';

const usersRouter = Router();

usersRouter.post('/register', registerUser);
usersRouter.post('/verify', verifyUser);
usersRouter.post('/forgotPassword', forgotPassword);
usersRouter.post('/resetPassword', resetPassword);
usersRouter.post('/checkValidLinkResetPassword', checkValidLinkResetPassword);
usersRouter.post('/checkforSignUp', checkForSignUp);

usersRouter.use(ensureAuthenticated);

usersRouter.post('/', inviteUser);
usersRouter.patch('/:id/changePassword', changeUserPassword);
usersRouter.delete('/:id', deleteUser);
usersRouter.post('/requestApplication', requestApplication);

export default usersRouter;
