#!/bin/sh

# Attendre que MariaDB soit prêt
echo "Waiting for MariaDB to be ready..."
while ! nc -z mariadb 3306; do
    sleep 1
done
echo "MariaDB ready !"

if [ ! -e "/var/www/html/wp-config.php" ]; then
	echo "Configuration of WordPress..."

	wp config create --allow-root					\
					 --dbname=$SQL_DB				\
					 --dbuser=$SQL_USER				\
					 --dbpass=$SQL_PASS			    \
					 --dbhost=mariadb:3306			\
					 --path='/var/www/html'

	wp core install	--allow-root					\
					--url=$WP_URL					\
					--title=$WP_TITLE				\
					--admin_email=$WP_ADMIN_EMAIL	\
					--admin_user=$WP_ADMIN			\
					--admin_password=$WP_ADMIN_PASS	\
					--skip-email					\
					--path='/var/www/html'

	wp user create	$WP_USER $WP_USER_EMAIL			\
					--allow-root					\
					--role=author					\
					--user_pass=$WP_USER_PASS		\

	wp option update home 'https://ehay.42.fr' --allow-root
	wp option update siteurl 'https://ehay.42.fr' --allow-root

	echo "WordPress is configured."

else
	echo "WordPress is already configured."
fi

exec php-fpm82 -F