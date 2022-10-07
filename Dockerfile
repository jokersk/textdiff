From node:16

WORKDIR /var/www/html

COPY package.json /var/www/html

RUN npm i -g pnpm

RUN pnpm i

COPY . /var/www/html

