FROM php:7.4-cli
LABEL author="IsaacAyanda"

RUN apt update \
	&& apt install -y libpng-dev zlib1g-dev libxml2-dev libzip-dev libonig-dev zip curl unzip \
	&& docker-php-ext-configure gd \
	&& docker-php-ext-install pdo pdo_mysql sockets mysqli zip -j$(nproc) gd \
	&& docker-php-source delete

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app
COPY . .
RUN mv .env.sample .env
EXPOSE 8000

ENTRYPOINT [ "sh", "serve.sh" ]