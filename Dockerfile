#build stage for a Node.js application
FROM node:lts-alpine as build-stage
WORKDIR /usr/src/app
COPY ./app/package*.json ./
RUN npm install
COPY ./app/. .
RUN npm run build

#production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage usr/src/app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]