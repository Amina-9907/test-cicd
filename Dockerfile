# Stage 1: Build the React app
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . . 
RUN npm run build


FROM nginx:stable-alpine
RUN mkdir -p /tmp/nginx-cache \
    && chmod -R 777 /tmp/nginx-cache

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]]
