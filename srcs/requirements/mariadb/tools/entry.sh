#!/bin/sh


# Démarrer MariaDB pour initialisation
mysqld_safe --bind-address=0.0.0.0 &
MARIADB_PID=$!

# Attendre que MariaDB soit prêt
while ! mysqladmin ping --silent; do
    sleep 1
done

DB_EXISTS=$(mariadb -u root -e "SHOW DATABASES LIKE '$SQL_DB';" | grep "$SQL_DB")
if [ -z "$DB_EXISTS" ]; then
    echo "Create bdd"

    mariadb -u root <<EOF
    DROP USER IF EXISTS $SQL_USER@'wordpress.inception';
    CREATE USER $SQL_USER@'wordpress.inception' IDENTIFIED BY "$SQL_PASS";
    DROP DATABASE IF EXISTS $SQL_DB;
    CREATE DATABASE $SQL_DB;

    GRANT ALL PRIVILEGES ON $SQL_DB.* TO $SQL_USER@'wordpress.inception';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASS';
    FLUSH PRIVILEGES;
EOF

echo "End create bdd"

fi

# Arrêter le service temporaire
mysqladmin -u root -p"$SQL_ROOT_PASS" shutdown

# Redémarrer MariaDB en mode réseau accessible
exec mysqld_safe --bind-address=0.0.0.0