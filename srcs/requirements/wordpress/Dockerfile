# Install alpine 3.19 for the base
FROM alpine:3.19

# Mise à jour et installation des dépendances nécessaires pour wordpress et php-fpm
RUN apk update && apk upgrade && apk add --no-cache php-fpm php-mysqli php-phar php-iconv wget



##### Faire tout le reste #####



# Exposer le port 9000 pour WordPress avec nginx
EXPOSE 9000

# Ajouter le script pour 
ADD tools/entry.sh /scripts/entry.sh
RUN chmod +x /scripts/entry.sh

# Redirect PHP-FPM logs
RUN ln -sf /dev/stdout /var/log/php7.4-fpm.log

# Script qui va s'executer au demarrage
ENTRYPOINT ["/scripts/entry.sh"]
