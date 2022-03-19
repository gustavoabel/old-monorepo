/*------------------------------------------------------------------------------------
 LOAD APPLICATION DATA
 ------------------------------------------------------------------------------------*/

alter table ${security_schema}.application disable trigger after_insert_application;
alter sequence ${security_schema}.application_id_seq restart with 1;
insert into ${security_schema}.application(app_environment, assigned_by_default, code, name, url, description, icon, parameters) values(
    'PRODUCTION',
    false,
    '${app_code}',
    '${app_name}',
    '/${app_code}',
    '${app_desc}',
    'data:image/svg+xml;base64,PCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDIzLjAuNiwgU1ZHIEV4cG9ydCBQbHVnLUluICAtLT4NCjxzdmcgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIgd2lkdGg9IjQ5NS4ycHgiDQoJIGhlaWdodD0iNDk1LjJweCIgdmlld0JveD0iMCAwIDQ5NS4yIDQ5NS4yIiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA0OTUuMiA0OTUuMjsiIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPHN0eWxlIHR5cGU9InRleHQvY3NzIj4NCgkuc3Qwe2ZpbGw6I0UxMDgxNDt9DQoJLnN0MXtmaWxsOiMwNzc1QkM7fQ0KCS5zdDJ7ZmlsbDojRkZGRkZGO30NCjwvc3R5bGU+DQo8ZGVmcz4NCjwvZGVmcz4NCjxwb2x5Z29uIGNsYXNzPSJzdDAiIHBvaW50cz0iMjQ2LjksMCAyNDYuOSwxNjUuMSAzMzAuMSwxNjUuMSAzMzAuMSwyNDYuOSA0OTUuMiwyNDYuOSA0OTUuMiwwICIvPg0KPHBvbHlnb24gY2xhc3M9InN0MSIgcG9pbnRzPSIzMzAuMSw0OTUuMiAzMzAuMSwzMzAuMSAxNjUuMSwzMzAuMSAxNjUuMSwxNjUuMSAwLDE2NS4xIDAsNDk1LjIgIi8+DQo8cmVjdCB4PSIyMDYiIHk9IjIwNiIgY2xhc3M9InN0MiIgd2lkdGg9IjgzLjIiIGhlaWdodD0iODMuMiIvPg0KPC9zdmc+DQo=',
    '[
        {
            "type": "TextInput",
            "props": {
            "label": { "en_US": "E-mail / Server", "pt_BR": "E-mail / Servidor" },
            "name": "emailHost"
            }
        },
        {
            "type": "NumberInput",
            "props": {
            "label": { "en_US": "E-mail / Port", "pt_BR": "E-mail / Porta" },
            "name": "emailPort"
            }
        },
        {
            "type": "TextInput",
            "props": {
            "label": { "en_US": "E-mail / Username", "pt_BR": "E-mail / Usuário" },
            "name": "emailUsername"
            }
        },
        {
            "type": "TextInput",
            "props": {
            "label": { "en_US": "E-mail / Password", "pt_BR": "E-mail / Senha" },
            "name": "emailPassword",
            "password": true
            }
        },
        {
            "type": "Switch",
            "props": {
            "label": { "en_US": "User name defined by e-mail address?", "pt_BR": "Usuário definido por endereço de e-mail?" },
            "name": "isUserDefinedByEmail"
            }
		},
        {
            "type": "TextArea",
            "props": {
            "label": { "en_US": "List of e-mail domains not allowed in the platform", "pt_BR": "Lista de domínios de e-mail não permitidos na plataforma" },
            "name": "deniedDomains"
            }
		},
        {   "type":"TextInput",
            "props": {
            "label": { "en_US":"Flexmonster License Key","pt_BR":"Código de Licença do Flexmonster" },
            "name":"flexmonsterLicense",
            "password":true
            }
        }
    ]'
);
alter table ${security_schema}.application enable trigger after_insert_application;

alter sequence ${security_schema}.domain_type_id_seq restart with 1;


alter sequence ${security_schema}.resource_type_id_seq restart with 1;
insert into ${security_schema}.resource_type(application_id, name, is_primary, type)
    select
        application.id, tables.name, false, 'TABLE'
    from
        (
            select table_name as name 
            from information_schema.tables 
            where table_schema = '${security_schema}' and table_name not in ('domain_entity', 'refresh_token') and table_type = 'BASE TABLE'
        ) as tables,
        (
            select id from ${security_schema}.application where code = '${app_code}'
        ) as application
on conflict (application_id, name) do nothing;

update ${security_schema}.resource_type set is_primary = true where name = 'application';
update ${security_schema}.resource_type set is_primary = true where name = 'identity_provider';
update ${security_schema}.resource_type set is_primary = true where name = 'role';
update ${security_schema}.resource_type set is_primary = true where name = 'user';


insert into ${security_schema}.permission(resource_type_id, action)
    select p.id, 'READ' from (select id from ${security_schema}.resource_type order by id) as p
on conflict (resource_type_id, action) do nothing;

insert into ${security_schema}.permission(resource_type_id, action)
    select p.id, 'WRITE' from (select id from ${security_schema}.resource_type order by id) as p
on conflict (resource_type_id, action) do nothing;



alter sequence ${security_schema}.role_id_seq restart with 1;
insert into ${security_schema}.role(application_id, name, is_admin, assigned_by_default) values(
    (select id from ${security_schema}.application where code = '${app_code}'),
    'Administrator',
    true,
    false
);


alter sequence ${security_schema}.identity_provider_type_id_seq restart with 1;
insert into ${security_schema}.identity_provider_type(name, has_sign_up, has_change_password) values(
    'Local Database',
    true,
    true
);


alter sequence ${security_schema}.identity_provider_id_seq restart with 1;
insert into ${security_schema}.identity_provider(identity_provider_type_id, name, status, description, param_val, is_default) values(
    (select id from ${security_schema}.identity_provider_type where name = 'Local Database'),
    'Local Database',
    'ACTIVE',
    'Local database user directory',
    '{"specialChars":"!@#$%^&*","minSize":6,"word":"test,ok"}',
    true
);

insert into ${security_schema}.pwd_policy (name, status, param_def, source) values (
    'Must start with letter',
    'ACTIVE',
    null,
    'async (password, config, utils) =>
    ({ valid: /^[a-z]/i.test(password), message:
    { en_US: `The password must start with a letter`,
      pt_BR: `A senha deve começar com uma letra` }, })'
);
insert into ${security_schema}.pwd_policy (name, status, param_def, source) values (
    'Must contain special character',
    'ACTIVE',
    '[{
        "type": "TextInput",
        "props": {
          "label": { "en_US": "Special characters", "pt_BR": "Caracteres especiais" },
          "name": "specialChars",
          "hint": { "en_US": "", "pt_BR": "" }
        }
      }]',
    'async (password, config, utils) =>
    { const matcher = new RegExp(`[$' || '{config.specialChars}]`);
    return { valid: matcher.test(password),
    message:
    { en_US: `The password must contain at least one special character $' || '{config.specialChars}`,
    pt_BR: `A senha deve conter pelo menos um caractere especial $' || '{config.specialChars}`, }, }; };'
);
insert into ${security_schema}.pwd_policy (name, status, param_def, source) values (
    'Must be longer than',
    'ACTIVE',
    '[{
        "type": "NumberInput",
        "props": {
          "label": { "en_US": "Minimum size", "pt_BR": "Tamanho mínimo" },
          "name": "minSize",
          "hint": { "en_US": "", "pt_BR": "" }
        }
      }]',
    'async (password, config, utils) =>
    ({ valid: password.length >= config.minSize,
    message: { en_US: `The password must contain at least $' || '{config.minSize} characters`,
    pt_BR: `A senha deve conter pelo menos $' || '{config.minSize} caracteres`, }, });'
);
insert into ${security_schema}.pwd_policy (name, status, param_def, source) values (
    'Cannot contain words from dictionary',
    'ACTIVE',
    '[{
        "type": "TextArea",
        "props": {
          "label": { "en_US": "Words", "pt_BR": "Palavras" },
          "name": "word",
          "hint": { "en_US": "", "pt_BR": "" }
        }
      }]',
    'async (password, config, utils) => { const { word } = config; const index = word.split(",").findIndex((w) =>
    password.includes(w)); return { valid: index === -1,
    message: { en_US: `The password contain one word from a list of forbidden words ($' || '{word})`,
    pt_BR: `A senha contém uma palavra de uma lista de palavras proibidas ($' || '{word})`, }, }; };'
);


-- Other identity provider types

insert into ${security_schema}.identity_provider_type(name, param_def, sign_in_source) values(
    'Microsoft Active Directory',
    '[
        {
            "type": "TextInput",
            "props": {
            "label": { "en_US": "Server", "pt_BR": "Servidor" },
            "name": "hostname"
            }
        },
        {
            "type": "NumberInput",
            "props": {
            "label": { "en_US": "Port", "pt_BR": "Porta" },
            "name": "port"
            }
        },
        {
            "type": "TextInput",
            "props": {
            "label": { "en_US": "Username", "pt_BR": "Usuário" },
            "name": "username"
            }
        },
        {
            "type": "TextInput",
            "props": {
            "label": { "en_US": "Password", "pt_BR": "Senha" },
            "name": "password",
            "password": true
            }
        },
        {
            "type": "TextInput",
            "props": {
            "label": { "en_US": "Base DN (Distinguished Name)", "pt_BR": "DN (Nome Distinto) Básico" },
            "name": "baseDN",
            "hint": { "en_US": "The Base DN is the starting point an LDAP server uses when searching for users authentication within the user directory (for example, DC=example-domain,DC=com).", "pt_BR": "O DN básico é o ponto de início usado pelo servidor LDAP para realizar a busca por usuários no diretório, no momento da autenticação (por exemplo, DC=example-domain,DC=com)." }
            }
        },
        {
            "type": "TextArea",
            "props": {
            "label": { "en_US": "Supported domains", "pt_BR": "Domínios suportados" },
            "name": "supportedDomains",
            "hint": { "en_US": "Insert the list of domains supported for this Identity Provider, one per line. e.g. sms-group.com", "pt_BR": "Insira a lista de domínios suportados para este Provedor de Identidade, um por linha. ex. sms-group.com" }
            }
        }
    ]',

    'async (username, password, config, utils) => {
  try {
    utils.installModules([''activedirectory2'']);
    const ActiveDirectory = require(''activedirectory2'');
    const adConfig = {
      url: ''ldap://'' + config.hostname + '':'' + config.port,
      baseDN: config.baseDN,
    };
    const ad = new ActiveDirectory(adConfig);
    return new Promise((resolve) =>
      ad.authenticate(username, password, (error, auth) => {
        if (error) console.log(error);
        resolve({ ok: auth });
      }),
    );
  } catch (error) {
    console.log(error);
    return { ok: false };
  }
};'
);

insert into ${security_schema}.identity_provider_type(name, sign_in_source,  has_refresh, refresh_source, param_def, has_sign_up, sign_up_source, has_change_password, change_password_source, has_delete_user, delete_user_source) values(
    'Microsoft B2C',
    'async (username, password, config) => {
  try {
    const { create } = require(''@sms/plasma-api-client'');
    const endpoints = {
      signIn: {
        method: ''POST'',
        path:
          ''oauth2/v2.0/token?p={policy}&client_id={client_id}&nonce={nonce}&scope={scope}&response_type={response_type}&grant_type={grant_type}&password={password}&username={username}'',
      },
      getToken: {
        method: ''POST'',
        path: `{policy}/oauth2/v2.0/token?grant_type={grant_type}&client_id={client_id}&code={code}`,
      },
    };
    const api = create(endpoints, {
      path: `https://$' || '{config.tenant}.b2clogin.com/$' || '{config.tenant}.onmicrosoft.com`,
    });
    const { ok: success, data: response } = await api.signIn({
      params: {
        policy: config.policy,
        client_id: config.client_id,
        nonce: ''62be4034033227a9c62f2d424d27de8b'',
        scope: `https://$' || '{config.tenant}.onmicrosoft.com/api/read openid offline_access`,
        response_type: ''code'',
        grant_type: ''password'',
        password: escape(password),
        username,
      },
    });
    if (success && response.code) {
      const result = await api.getToken({
        params: {
          policy: config.policy,
          grant_type: ''authorization_code'',
          client_id: config.client_id,
          code: response.code,
        },
      });
      if (result.ok) {
        const { id_token, refresh_token, id_token_expires_in, refresh_token_expires_in } = result.data;
        return {
          ok: result.ok,
          data: {
            tokenExpiresIn: id_token_expires_in,
            refreshTokenExpiresIn: refresh_token_expires_in,
            token: id_token,
            refreshToken: refresh_token,
          },
        };
      }
    }
  } catch (err) {
    console.log(err);
  }
  return { ok: false, data: {} };
};',
    true,
    'async (refresh_token, config) => {
    try {
    const { create } = require(''@sms/plasma-api-client'');
    const qs = require(''qs'');
    const api = create(
      { refreshToken: { method: ''POST'', path: `{policy}/oauth2/v2.0/token` } },
      {
        path: `https://$' || '{config.tenant}.b2clogin.com/$' ||  '{config.tenant}.onmicrosoft.com`,
        headers: { ''Content-Type'': ''application/x-www-form-urlencoded'' },
      },
    );
    const result = await api.refreshToken({
      params: { policy: config.policy },
      data: qs.stringify({ grant_type: ''refresh_token'', refresh_token, client_id: config.client_id }),
    });
    if (result.ok) {
      const { id_token, id_token_expires_in } = result.data;
      return { ok: result.ok, data: { token: id_token, tokenExpiresIn: id_token_expires_in } };
    }
  } catch (err) {
    console.log(err);
  }
  return { ok: false, data: {} };
  };',
    '[
    {
        "type": "TextInput",
        "props": {
        "label": { "en_US": "Tenant", "pt_BR": "Tenant" },
        "name": "tenant"
        }
    },
    {
        "type": "TextInput",
        "props": {
        "label": { "en_US": "Tenant ID", "pt_BR": "ID do Tenant" },
        "name": "tenant_id"
        }
    },
    {
        "type": "TextInput",
        "props": {
        "label": { "en_US": "Flow Policy", "pt_BR": "Regra de fluxo" },
        "name": "policy"
        }
    },
    {
        "type": "TextInput",
        "props": {
        "label": { "en_US": "Client ID", "pt_BR": "ID de cliente(aplicação)" },
        "name": "client_id"
        }
    },
    {
        "type": "TextInput",
        "props": {
        "label": { "en_US": "Client Secret", "pt_BR": "Segredo do cliente(aplicação)" },
        "name": "client_secret"
        }
    }
  ]',
  true,
  'async (user, config) => {
  try {
    const { create } = require(''@sms/plasma-api-client'');
    const qs = require(''qs'');
    const endpoints = {
      getToken: { method: ''POST'', path: '''' },
      signUp: { method: ''POST'', path: '''' },
      getUserByEmail: {
        method: ''GET'',
        path: "?$filter=identities/any(c:c/issuerAssignedId eq ''{email}'' and c/issuer eq ''contoso.onmicrosoft.com'')",
      },
    };
    const api = create(endpoints, {
      path: `https://login.microsoftonline.com/$' || '{config.tenant_id}/oauth2/v2.0/token`,
      headers: { ''Content-Type'': ''application/x-www-form-urlencoded'' },
    });
    const { ok, data } = await api.getToken({
      data: qs.stringify({
        grant_type: ''client_credentials'',
        client_id: config.client_id,
        scope: ''https://graph.microsoft.com/.default'',
        client_secret: config.client_secret,
      }),
    });
    if (ok && data.token_type && data.access_token) {
      const { token_type, access_token } = data;
      const userApi = create(endpoints, {
        path: ''https://graph.microsoft.com/v1.0/users'',
        headers: { authorization: `$' || '{token_type} $' || '{access_token}` },
      });
      const response = await userApi.getUserByEmail({ params: { email: user.email } });
      if (response.ok) {
        if (response.data.value.length) return true;
        const result = await userApi.signUp({
          headers: { authorization: `$' || '{token_type} $' || '{access_token}` },
          data: {
            displayName: `$' || '{user.first_name} $' || '{user.last_name}`,
            mail: user.email,
            identities: [
              {
                signInType: ''emailAddress'',
                issuer: `$' || '{config.tenant}.onmicrosoft.com`,
                issuerAssignedId: user.email,
              },
            ],
            passwordProfile: {
              password: user.password,
              forceChangePasswordNextSignIn: false,
            },
            passwordPolicies: ''DisablePasswordExpiration'',
          },
        });
        return result.ok;
      }
    }
  } catch (err) {
    console.log(err);
  }
  return false;
};',
true,
'async (password, user, config) => {
  try {
    const { create } = require(''@sms/plasma-api-client'');
    const qs = require(''qs'');
    const endpoints = {
      getToken: { method: ''POST'', path: '''' },
      changePassword: { method: ''PATCH'', path: '''' },
      getUserByEmail: {
        method: ''GET'',
        path: "?$filter=identities/any(c:c/issuerAssignedId eq ''{email}'' and c/issuer eq ''contoso.onmicrosoft.com'')",
      },
    };
    // Get access token
    const accessApi = create(endpoints, {
      path: `https://login.microsoftonline.com/$' || '{config.tenant_id}/oauth2/v2.0/token`,
      headers: { ''Content-Type'': ''application/x-www-form-urlencoded'' },
    });
    const { ok, data } = await accessApi.getToken({
      data: qs.stringify({
        grant_type: ''client_credentials'',
        client_id: config.client_id,
        scope: ''https://graph.microsoft.com/.default'',
        client_secret: config.client_secret,
      }),
    });
    if (ok && data.token_type && data.access_token) {
      const { token_type, access_token } = data;
      // Get user by e-mail
      const api = create(endpoints, {
        path: ''https://graph.microsoft.com/v1.0/users'',
        headers: { authorization: `$' || '{token_type} $' || '{access_token}` },
      });
      const { ok: success, data: users } = await api.getUserByEmail({ params: { email: user.email } });
      if (success && users.value.length) {
        const { id } = users.value.shift();
        // Update user password
        const userApi = create(endpoints, {
          path: `https://graph.microsoft.com/v1.0/users/$' || '{id}`,
          headers: { authorization: `$' || '{token_type} $' || '{access_token}` },
        });
        const result = await userApi.changePassword({
          data: { passwordProfile: { password, forceChangePasswordNextSignIn: false } },
        });
        return result.ok;
      }
    }
  } catch {} // eslint-disable-line no-empty
  return false;
};',
true,
'async (user, config) => {
  try {
    const { create } = require(''@sms/plasma-api-client'');
    const qs = require(''qs'');
    const endpoints = {
      getToken: { method: ''POST'', path: '''' },
      deleteUser: { method: ''DELETE'', path: '''' },
      getUserByEmail: {
        method: ''GET'',
        path: "?$filter=identities/any(c:c/issuerAssignedId eq ''{email}'' and c/issuer eq ''contoso.onmicrosoft.com'')",
      },
    };
    // Get access token
    const accessApi = create(endpoints, {
      path: `https://login.microsoftonline.com/$' || '{config.tenant_id}/oauth2/v2.0/token`,
      headers: { ''Content-Type'': ''application/x-www-form-urlencoded'' },
    });
    const { ok, data } = await accessApi.getToken({
      data: qs.stringify({
        grant_type: ''client_credentials'',
        client_id: config.client_id,
        scope: ''https://graph.microsoft.com/.default'',
        client_secret: config.client_secret,
      }),
    });
    if (ok && data.token_type && data.access_token) {
      const { token_type, access_token } = data;
      // Get user by e-mail
      const api = create(endpoints, {
        path: ''https://graph.microsoft.com/v1.0/users'',
        headers: { authorization: `$' || '{token_type} $' || '{access_token}` },
      });
      const { ok: success, data: users } = await api.getUserByEmail({ params: { email: user.email } });
      if (success && users.value.length) {
        const { id } = users.value.shift();
        // Delete user
        const userApi = create(endpoints, {
          path: `https://graph.microsoft.com/v1.0/users/$' || '{id}`,
          headers: { authorization: `$' || '{token_type} $' || '{access_token}` },
        });
        const result = await userApi.deleteUser();
        return result.ok;
      }

      return success;
    }
  } catch {} // eslint-disable-line no-empty
  return false;
};'
);

insert into ${security_schema}.identity_provider_type(name, sign_in_source,  has_refresh, refresh_source, param_def) values(
    'Microsoft Azure AD',
    'async (username, password, config) => {
  try {
    const { create } = require(''@sms/plasma-api-client'');
    const qs = require(''qs'');
    const api = create(
      { signIn: { method: ''POST'', path: ''{tenant}/oauth2/v2.0/token'' } },
      {
        path: ''https://login.microsoftonline.com'',
        headers: { ''Content-Type'': ''application/x-www-form-urlencoded'' },
      },
    );
    const { ok, data } = await api.signIn({
      params: { tenant: config.tenant_id },
      data: qs.stringify({
        client_id: config.client_id,
        scope: ''User.Read profile openid email offline_access'',
        username,
        password: password,
        grant_type: ''password'',
      }),
    });
    if (ok)
      return {
        ok,
        data: {
          tokenExpiresIn: data.expires_in,
          refreshTokenExpiresIn: data.ext_expires_in,
          token: data.access_token,
          refreshToken: data.refresh_token,
        },
      };
  } catch (err) {
    console.log(err);
  }
  return { ok: false, data: {} };
};',
    true,
    'async (refresh_token, config) => {
  try {
    const { create } = require(''@sms/plasma-api-client'');
    const qs = require(''qs'');
    const api = create(
      { refreshToken: { method: ''POST'', path: ''{tenant}/oauth2/v2.0/token'' } },
      {
        path: ''https://login.microsoftonline.com'',
        headers: { ''Content-Type'': ''application/x-www-form-urlencoded'' },
      },
    );
    const { ok, data } = await api.refreshToken({
      params: { tenant: config.tenant_id },
      data: qs.stringify({ grant_type: ''refresh_token'', refresh_token, client_id: config.client_id }),
    });
    if (ok) return { ok, data: { token: data.access_token, tokenExpiresIn: data.expires_in } };
  } catch (err) {
    console.log(err);
  }
  return { ok: false, data: {} };
};',
    '[
  {
    "type": "TextInput",
    "props": {
      "label": { "en_US": "Tenant ID", "pt_BR": "ID do Tenant" },
      "name": "tenant_id"
    }
  },
  {
    "type": "TextInput",
    "props": {
      "label": { "en_US": "Client ID", "pt_BR": "ID de cliente (aplicação)" },
      "name": "client_id"
    }
  }
]'
);

-- Admin user

alter sequence ${security_schema}.user_id_seq restart with 1;
insert into ${security_schema}.user(identity_provider_id, username, password, first_name, last_name, is_admin) values(
    (select id from ${security_schema}.identity_provider where name = 'Local Database'),
    'admin@vetta.digital',
    '$2a$10$FJCvZqDkrFB27bo/xb.7aOGXcy83kXE4OH8eCEtomGBxlEFRNNwOu',
    'Platform',
    'Administrator',
    true
);


-- set default application parameters

update ${security_schema}.application
set parameters_value = '{
  "emailHost": "smtp.office365.com",
  "emailPort": 587,
  "emailUsername": "mail.delivery@vetta.digital",
  "emailPassword": "Joc07167",
  "isUserDefinedByEmail": true,
  "deniedDomains":"hotmail.com,gmail.com,yahoo.com"
}'
where code = '${app_code}';


-- generated by the Excel spreadsheet
					
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'domain' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'domain_type' and p.action = 'READ')
);													
																		
		
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'domain_item' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'domain' and p.action = 'READ')
);																

insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'domain_type' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'application' and p.action = 'READ')
);																		
							
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'identity_provider' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'identity_provider_type' and p.action = 'READ')
);											
																		
													
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'permission' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'resource_type' and p.action = 'READ')
);					
								
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'permission_inheritance' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'permission' and p.action = 'READ')
);										
																		
																		
					
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'resource_domain_type' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'domain_type' and p.action = 'READ')
);								
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'resource_domain_type' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'resource_type' and p.action = 'READ')
);					

insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'resource_type' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'application' and p.action = 'READ')
);																		

insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'role' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'application' and p.action = 'READ')
);															
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'role' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'role_permission' and p.action = 'READ')
);
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'role' and p.action = 'WRITE'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'role_permission' and p.action = 'WRITE')
);			
																		
	
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'contact_info' and p.action = 'READ')
);
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user' and p.action = 'WRITE'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'contact_info' and p.action = 'WRITE')
);					
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'identity_provider' and p.action = 'READ')
);											
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user_domain' and p.action = 'READ')
);
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user' and p.action = 'WRITE'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user_domain' and p.action = 'WRITE')
);	
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user_role' and p.action = 'READ')
);
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user' and p.action = 'WRITE'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user_role' and p.action = 'WRITE')
);

insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user_domain' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'application' and p.action = 'READ')
);				
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user_domain' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'domain_item' and p.action = 'READ')
);
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user_domain' and p.action = 'WRITE'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'domain_item' and p.action = 'WRITE')
);				
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user_domain' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'permission' and p.action = 'READ')
);										
														
insert into ${security_schema}.permission_inheritance(parent_permission_id, child_permission_id) values (
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'user_role' and p.action = 'READ'),
(select p.id from ${security_schema}.permission p, ${security_schema}.resource_type r where p.resource_type_id = r.id and r.name = 'role' and p.action = 'READ')
);				
