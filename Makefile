NAME = inception

DOCKER_COMPOSE_CMD = docker compose
DOCKER_COMPOSE_PATH = srcs/docker-compose.yaml

all:
	@if [ -f "./srcs/.env" ]; then													\
		mkdir -p /home/laubry/data/mariadb;										\
		mkdir -p /home/laubry/data/wordpress;										\
		cd srcs && $(DOCKER_COMPOSE_CMD) up --build -d; 							\
	else																			\
		echo "No .env file found in /srcs folder, please create one using example.env before trying to build";	\
	fi

stop:
	cd srcs && $(DOCKER_COMPOSE_CMD) stop

down:
	cd srcs && $(DOCKER_COMPOSE_CMD) down -v --remove-orphans
	docker system prune -af

clean: down
	rm -rf /home/laubry/data/mariadb/*
	rm -rf /home/laubry/data/wordpress/*
	docker volume prune -f
	docker network prune -f

fclean: clean
	docker rmi -f $$(docker images -q) 2>/dev/null || true
	docker system prune -af --volumes

re: down all

.PHONY: all stop down clean fclean re

