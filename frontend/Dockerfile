FROM node AS start-nginx

COPY . /app

WORKDIR /app

RUN npm install

# Nginx proxy
FROM nginx:alpine

COPY --from=start-nginx /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
