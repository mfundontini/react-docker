# This Dockerfile has two parts, building the image and then copying over the bundled data to nginx
FROM node:alpine as builder

WORKDIR /usr/app

COPY package.json ./

RUN npm install

COPY . .

RUN npm run build

# Now for the NGINX/running paret
FROM nginx

EXPOSE 80

COPY --from=builder /usr/app/build /usr/share/nginx/html