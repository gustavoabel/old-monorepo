FROM node:lts-alpine AS BUILD_IMAGE

WORKDIR /usr/app

ARG NPM_TOKEN
ARG NPM_TOKEN_FONT_AWESOME

COPY . .
COPY .production.npmrc .npmrc

# install dependencies
RUN npm ci

# build application
RUN npm run build

FROM node:lts-alpine

WORKDIR /usr/app

# copy from build image
COPY --from=BUILD_IMAGE /usr/app/build ./build
COPY --from=BUILD_IMAGE /usr/app/package.json ./
COPY --from=BUILD_IMAGE /usr/app/lws.config.js ./

CMD ["npx", "local-web-server"]
