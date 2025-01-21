COMPOSE = ./srcs/docker-compose.yml
DATA_DIR = /home/ehay/data

all: up

up:
	@mkdir -p $(DATA_DIR)/wordpress $(DATA_DIR)/db
	@docker compose -f $(COMPOSE) build --parallel
	@docker compose -f $(COMPOSE) up -d --build

down:
	@docker compose -f $(COMPOSE) down

clean:
	@docker compose -f $(COMPOSE) down -v

fclean:	clean
	@docker system prune --force --volumes --all
	@docker run --rm -v /home/ehay/data:/data alpine sh -c "chmod -R u+w /data"
	@docker run --rm -v $(DATA_DIR):/data alpine sh -c "rm -rf /data/*"
	@rm -rf $(DATA_DIR)

re:	fclean all

.PHONY: all up down clean fclean re

logs:
	@echo "---------- MARIADB -----------\n"
	@docker compose -f $(COMPOSE) logs mariadb
	@echo "\n---------- NGINX ------------\n"
	@docker compose -f $(COMPOSE) logs nginx
	@echo "\n-------- WORDPRESS ----------\n"
	@docker compose -f $(COMPOSE) logs wordpress