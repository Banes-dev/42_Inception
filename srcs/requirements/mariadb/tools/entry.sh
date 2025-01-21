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

	# mariadb -u root -e "
	# CREATE DATABASE IF NOT EXISTS $SQL_DB;
	# CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASS';
	# GRANT ALL PRIVILEGES ON $SQL_DB.* TO '$SQL_USER'@'%';
	# ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASS';
	# FLUSH PRIVILEGES;
	# SHUTDOWN;"

    mariadb -u root <<EOF
    CREATE DATABASE IF NOT EXISTS $SQL_DB;
    CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASS';
    GRANT ALL PRIVILEGES ON $SQL_DB.* TO '$SQL_USER'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASS';
    FLUSH PRIVILEGES;
EOF
fi

# Arrêter le service temporaire
mysqladmin -u root -p"$SQL_ROOT_PASS" shutdown

# Redémarrer MariaDB en mode réseau accessible
exec mysqld_safe --bind-address=0.0.0.0