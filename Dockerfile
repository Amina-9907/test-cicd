# Stage 1: Build the React app
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . . 
RUN npm run build

FROM nginx:stable-alpine AS production

COPY --from=builder /app/build /usr/share/nginx/html
RUN mkdir -p /var/cache/nginx/client_temp \
    && chown -R 1000:0 /var/cache/nginx \
    && chmod -R 755 /var/cache/nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
