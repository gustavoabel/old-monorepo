import { ErrorHandler } from '@sms/plasma-nodejs-api';
import jwt from 'jsonwebtoken';
import nodemailer from 'nodemailer';
import Mail from 'nodemailer/lib/mailer';

import forgotPasswordConfig from '../config/forgotPassword';
import registerConfig from '../config/register';
import { Application } from '../services/pgApi/application';

interface EmailConfig {
  host: string;
  port: number;
  user: string;
  pass: string;
}

interface User {
  id: number;
  email: string;
  first_name?: string;
  last_name?: string;
  username?: string;
  application_name?: string;
}

export const sendVerificationEmail = async (insertedUser: User, application: Application) => {
  const { parameters_value } = application;

  if (
    !parameters_value ||
    !parameters_value.emailHost ||
    !parameters_value.emailPort ||
    !parameters_value.emailUsername ||
    !parameters_value.emailPassword
  ) {
    throw new ErrorHandler(400, 'api.message.emailParametersNotFound');
  }

  const { emailHost: host, emailPort: port, emailUsername: user, emailPassword: pass } = parameters_value;
  const mailTransport = createTransport({ host, port, user, pass });

  const { secret, expiresIn } = registerConfig.jwt;
  const singUpToken = jwt.sign({ id: insertedUser.id }, secret, { expiresIn });
  const portalUrl = `${process.env.PORTAL_APP_URL}/verify?key=${singUpToken}`;

  await mailTransport.send({
    to: insertedUser.email,
    subject: getEmailSubjectRegisterUser(insertedUser.email, application.name),
    html: getEmailBodyRegisterUser(insertedUser.email, portalUrl, application.name),
  });
};

export const sendResetPasswordEmail = async (user: User, application: Application) => {
  const { parameters_value } = application;

  if (
    !parameters_value ||
    !parameters_value.emailHost ||
    !parameters_value.emailPort ||
    !parameters_value.emailUsername ||
    !parameters_value.emailPassword
  ) {
    throw new ErrorHandler(400, 'api.message.emailParametersNotFound');
  }

  const { emailHost: host, emailPort: port, emailUsername, emailPassword: pass } = parameters_value;
  const mailTransport = createTransport({ host, port, user: emailUsername, pass });

  const { secret, expiresIn } = forgotPasswordConfig.jwt;
  const singUpToken = jwt.sign({ id: user.id }, secret, { expiresIn });
  const portalUrl = `${process.env.PORTAL_APP_URL}/resetPassword?key=${singUpToken}`;

  await mailTransport.send({
    to: user.email,
    subject: 'Time to recover your password',
    html: getEmailBodyForgotPasswordUser(user.email, portalUrl, application.name),
  });
};

export const sendUserInviteEmail = async (domain: string, usernames: string[], application: Application) => {
  const { parameters_value } = application;

  if (
    !parameters_value ||
    !parameters_value.emailHost ||
    !parameters_value.emailPort ||
    !parameters_value.emailUsername ||
    !parameters_value.emailPassword
  ) {
    throw new ErrorHandler(400, 'api.message.emailParametersNotFound');
  }

  const { emailHost: host, emailPort: port, emailUsername: user, emailPassword: pass } = parameters_value;
  const mailTransport = createTransport({ host, port, user, pass });
  const { secret, expiresIn } = registerConfig.jwt;

  const sendEmailPromises = usernames.map((username) => {
    const email = [username, domain].join('@');
    const newUser = { username: parameters_value?.isUserDefinedByEmail ? email : username, email };
    const singUpToken = jwt.sign(newUser, secret, { expiresIn });
    const portalUrl = `${process.env.PORTAL_APP_URL}/register?key=${singUpToken}`;

    return mailTransport.send({
      to: email,
      subject: getUserCreateEmailSubject(email, application.name),
      html: getUserCreateEmailBody(email, portalUrl, application.name),
    });
  });

  await Promise.all(sendEmailPromises);
};

export const sendApplicationRequestEmail = async (user: User, owners: User[], application: Application) => {
  const { parameters_value } = application;

  if (
    !parameters_value ||
    !parameters_value.emailHost ||
    !parameters_value.emailPort ||
    !parameters_value.emailUsername ||
    !parameters_value.emailPassword
  ) {
    throw new ErrorHandler(400, 'api.message.emailParametersNotFound');
  }

  const { emailHost: host, emailPort: port, emailUsername, emailPassword: pass } = parameters_value;
  const mailTransport = createTransport({ host, port, user: emailUsername, pass });

  const sendEmailPromises = owners.map((owner) => {
    const portalUrl = `${process.env.PORTAL_APP_URL}/security/users/${user.id}`;

    return mailTransport.send({
      to: owner.email,
      subject: `Your action is required: ${owner.application_name} access request requires your approve`,
      html: getRequestApplicationEmailBody(user, portalUrl, application.name, owner.application_name),
    });
  });

  await Promise.all(sendEmailPromises);
};

export const createTransport = (config: EmailConfig) => {
  const { host, port, user, pass } = config;

  const smtpConnectionString = {
    host,
    port,
    auth: { user, pass },
    secureConnection: false,
    tls: { ciphers: 'SSLv3' },
  };

  const mailTransport = nodemailer.createTransport(smtpConnectionString);

  const send = (options: Omit<Mail.Options, 'from'>) => mailTransport.sendMail({ from: user, ...options });

  return { send };
};

export const getUserCreateEmailSubject = (email: string, applicationName: string) => {
  return `Confirm ${email} on ${applicationName}`;
};

export const getUserCreateEmailBody = (email: string, url: string, applicationName: string) => {
  return `<style>
  #email {
    font-family: Roboto, sans-serif;
    background-color: #ffffff;
    padding: 20px 0;
    width: 100%;
  }

  #email td:nth-of-type(1) {
    margin: 0 auto;
    width: 600px;
    display: block;
  }

  #email td:nth-child(1) > div {
    padding: 30px 0;
  }

  .title {
    font-size: 30px;
    color: #434245;
  }

  .description {
    font-size: 17px;
    color: #434245;
  }

  .confirmation {
    margin: 30px 0;
  }

  .button {
    min-width: 230px;
    color: #ffffff;
    background-color: #0075be;
    border: 13px solid #0075be;
    border-radius: 4px;
    font-size: 20px;
    display: inline-block;
    text-align: center;
    vertical-align: top;
    font-weight: 900;
    text-decoration: none !important;
  }
</style>
<table id="email">
  <tbody>
    <tr>
      <td>
        <div>
          <h1 class="title"><span>Confirm</span> your email address on <span>${applicationName}</span></h1>
          <p class="description">
            Hello! We just need to verify that
            <strong><a href="mailto:${email}" target="_blank">${email}</a></strong> is your email address, and then
            we'll help you sign up on ${applicationName}.
          </p>
          <div class="confirmation">
            <a class="button" href="${url}"> <span>Confirm</span> Email Address </a>
          </div>
        </div>
      </td>
    </tr>
  </tbody>
</table>
`;
};

export const getEmailSubjectRegisterUser = (email: string, applicationName: string) => {
  return `Confirm ${email} on ${applicationName}`;
};

export const getEmailBodyRegisterUser = (email: string, url: string, applicationName: string) => {
  return `
    <style>
      #email {
        font-family: Roboto, sans-serif;
        background-color: #ffffff;
        padding: 20px 0;
        width: 100%;
      }

      #email td:nth-of-type(1) {
        margin: 0 auto;
        width: 600px;
        display: block;
      }

      #email td:nth-child(1) > div {
        padding: 30px 0;
      }

      .title {
        font-size: 30px;
        color: #434245;
      }

      .description {
        font-size: 17px;
        color: #434245;
      }

      .confirmation {
        margin: 30px 0;
      }

      .button {
        min-width: 230px;
        color: #ffffff;
        background-color: #0075be;
        border: 13px solid #0075be;
        border-radius: 4px;
        font-size: 20px;
        display: inline-block;
        text-align: center;
        vertical-align: top;
        font-weight: 900;
        text-decoration: none !important;
      }
    </style>
    <table id="email">
      <tbody>
        <tr>
          <td>
            <div>
              <h1 class="title"><span>Confirm</span> your email address on <span>${applicationName}</span></h1>
              <p class="description">
                Hello! We just need to verify that
                <strong><a href="mailto:${email}" target="_blank">${email}</a></strong> is your email address.
              </p>
              <div class="confirmation">
                <a class="button" href="${url}"> <span>Confirm</span> Email Address </a>
              </div>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  `;
};

export const getEmailBodyForgotPasswordUser = (email: string, url: string, applicationName: string) => {
  return `
    <style>
      #email {
        font-family: Roboto, sans-serif;
        background-color: #ffffff;
        padding: 20px 0;
        width: 100%;
      }

      #email td:nth-of-type(1) {
        margin: 0 auto;
        width: 600px;
        display: block;
      }

      #email td:nth-child(1) > div {
        padding: 30px 0;
      }

      .title {
        font-size: 30px;
        color: #434245;
      }

      .description {
        font-size: 17px;
        color: #434245;
      }

      .confirmation {
        margin: 30px 0;
      }

      .button {
        min-width: 230px;
        color: #ffffff;
        background-color: #0075be;
        border: 13px solid #0075be;
        border-radius: 4px;
        font-size: 20px;
        display: inline-block;
        text-align: center;
        vertical-align: top;
        font-weight: 900;
        text-decoration: none !important;
      }
    </style>
    <table id="email">
      <tbody>
        <tr>
          <td>
            <div>
              <p class="description">
                A password recovery request was made for your account <strong><a href="mailto:${email}" target="_blank">${email}</a></strong> in the ${applicationName}.
              </p>
              <p class="description">
                To continue with password recovery click on the button below to create a new password. Ah, this link expires in 24 hours.
              </p>
              <div class="confirmation">
                <a class="button" href="${url}"> Create new password </a>
              </div>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  `;
};

export const getRequestApplicationEmailBody = (
  user: User,
  url: string,
  applicationName: string,
  requestApplicationName?: string,
) => {
  return `
    <style>
      #email {
        font-family: Roboto, sans-serif;
        background-color: #ffffff;
        padding: 20px 0;
        width: 100%;
      }

      #email td:nth-of-type(1) {
        margin: 0 auto;
        width: 600px;
        display: block;
      }

      #email td:nth-child(1) > div {
        padding: 30px 0;
      }

      .title {
        font-size: 30px;
        color: #434245;
      }

      .description {
        font-size: 17px;
        color: #434245;
      }

      .confirmation {
        margin: 30px 0;
      }

      .button {
        min-width: 230px;
        color: #ffffff;
        background-color: #0075be;
        border: 13px solid #0075be;
        border-radius: 4px;
        font-size: 20px;
        display: inline-block;
        text-align: center;
        vertical-align: top;
        font-weight: 900;
        text-decoration: none !important;
      }
    </style>
    <table id="email">
      <tbody>
        <tr>
          <td>
            <div>
              <p class="description">
                ${user.first_name} ${user.last_name} (${user.username}) has requested access to ${requestApplicationName}. Your approval is required for this request.
              </p>
              <p class="description">
                Press <strong>Approve Request</strong> to access the <strong>${applicationName}</strong> and assign the user a role to access the requested application.
              </p>
              <div class="confirmation">
                <a class="button" href="${url}"> Approve Request</a>
              </div>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  `;
};
