# Install alpine 3.19 for the base
FROM alpine:3.19

# Mise à jour et installation des dépendances nécessaires pour wordpress et php-fpm
RUN apk update && apk upgrade && apk add --no-cache php-fpm php-mysqli php-phar php-iconv wget

# Supprimer le group par defaut puis le refaire sans login pour la securite
RUN delgroup www-data
RUN adduser -D -H -s /sbin/nologin www-data

# Cree dossier pour php-fpm et ajuste les perms
RUN mkdir -p /run/php
RUN chown -R www-data:www-data /run/php

# Cree dossier pour wordpress et ajuste les perms
RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Installation de Wordpress
WORKDIR /var/www/html
RUN wget https://wordpress.org/wordpress-6.4.3.tar.gz \
	&& tar -xvf wordpress-6.4.3.tar.gz --strip-components 1 \
	&& rm -rf wordpress-6.4.3.tar.gz

# Installation de WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# Configurer php-fpm
COPY config/www.conf /etc/php82/php-fpm.d/www.conf

# Ajouter le script pour configurer le WordPress
ADD tools/entry.sh /scripts/entry.sh
RUN chmod +x /scripts/entry.sh

# Redirect PHP-FPM logs
RUN ln -sf /dev/stdout /var/log/php7.4-fpm.log

# Exposer le port 9000 pour WordPress avec nginx
EXPOSE 9000

# Script qui va s'executer au demarrage
ENTRYPOINT ["/scripts/entry.sh"]
