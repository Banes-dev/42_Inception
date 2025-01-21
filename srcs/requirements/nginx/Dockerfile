# Install alpine 3.19 for the base
FROM alpine:3.19

# Mise à jour et installation des dépendances nécessaires pour MariaDB
RUN apk update && apk upgrade && apk add --no-cache nginx openssl

# Créer un certificat auto-signé pour HTTPS
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/cert.key \
    -out /etc/ssl/certs/cert.crt \
    -subj "/C=FR/ST=LeHavre/L=LeHavre/O=42/OU=42/CN=ehay.42.fr"

# Copier le fichier de configuration Nginx
COPY config/nginx.conf /etc/nginx/

# Redirige les logs Nginx vers la sortie standard (stdout/stderr)
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

# Exposer le port HTTPS (443)
EXPOSE 443

# Démarrage
CMD ["nginx", "-g", "daemon off;"]
