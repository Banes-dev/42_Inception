# Install alpine 3.19 for the base
FROM alpine:3.19

# Mise à jour et installation des dépendances nécessaires pour MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

# Créer un répertoire pour les données de la base de données
RUN mkdir -p /var/lib/mysql

# Initialisation de la base de données
RUN mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Commande par défaut pour démarrer MariaDB
CMD ["mysqld", "--user=mysql", "--console"]
