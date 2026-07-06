# docker run --rm -it -p 80:80 .

FROM node:24 as build
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
#COPY package.json package-lock.json ./
ADD https://github.com/Entkenntnis/robot-karol-online.git .
RUN npm install
#COPY . .
RUN npm run build

FROM nginx
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
