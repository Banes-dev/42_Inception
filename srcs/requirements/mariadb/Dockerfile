# Install alpine 3.19 for the base
FROM alpine:3.19

# Mise à jour et installation des dépendances nécessaires pour MariaDB
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

# Créer un répertoire pour les données de la base de données
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# Ajouter le script pour init bdd
COPY tools/entry.sh /scripts/entry.sh
RUN chmod +x /scripts/entry.sh

# Configurer mariadb
ADD config/mariadb.conf /etc/my.cnf.d/mariadb-server.cnf

# Exposer le port 3306 pour MariaDB
EXPOSE 3306

RUN mariadb-install-db

# Script qui va s'executer au demarrage
ENTRYPOINT ["/scripts/entry.sh"]
