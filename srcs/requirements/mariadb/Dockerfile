# Install alpine 3.19 for the base
FROM alpine:3.19

# Mise à jour et installation des dépendances nécessaires pour MariaDB
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

# Créer un répertoire pour les données de la base de données
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# Exposer le port 3306 pour MariaDB
EXPOSE 3306

# Ajouter le script pour init bdd
ADD tools/entry.sh /scripts/entry.sh
RUN chmod +x /scripts/entry.sh

# Script qui va s'executer au demarrage
ENTRYPOINT ["/scripts/entry.sh"]
