import { ApiEndpointConfig } from '@sms/plasma-api-client';

type EndpointType =
  | 'queryMany'
  | 'queryOne'
  | 'insertMany'
  | 'insertOne'
  | 'updateMany'
  | 'updateOne'
  | 'delete'
  | 'rpcMany'
  | 'rpcOne';

const createRequestBuilder = (schema: string) => (type: EndpointType, url: string) => {
  const path = `/${type.replace(/Many|One/, '')}/${schema}${url}`;

  const resultMap: Record<EndpointType, ApiEndpointConfig> = {
    queryMany: { method: 'GET', path },
    queryOne: { method: 'GET', path, singleResult: true },
    insertMany: { method: 'POST', path },
    insertOne: { method: 'POST', path, requestDataIsArray: true, singleResult: true },
    updateMany: { method: 'PATCH', path },
    updateOne: { method: 'PATCH', path, requestDataIsArray: true, singleResult: true },
    delete: { method: 'DELETE', path },
    rpcMany: { method: 'GET', path },
    rpcOne: { method: 'GET', path, singleResult: true },
  };

  return resultMap[type];
};

export const baseSchemaBuilder = createRequestBuilder(process.env.SECURITY_SCHEMA as string);
