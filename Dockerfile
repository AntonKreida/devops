FROM node:18-alpine as build
WORKDIR /app

COPY package*.json ./
RUN yarn install

COPY . .
RUN yarn build

FROM nginx:1.25.4-alpine3.18
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /var/www/html/
EXPOSE 3000
ENTRYPOINT ["nginx","-g","daemon off;"]