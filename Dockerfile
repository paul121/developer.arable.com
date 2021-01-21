FROM node:15.5-alpine3.10 as build-deps

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn
COPY . ./
RUN yarn docs:build


FROM nginx:1.19.6-alpine

COPY --from=build-deps /app/docs/.vuepress/dist /usr/share/nginx/html
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
