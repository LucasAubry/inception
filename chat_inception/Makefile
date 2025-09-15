.PHONY: all build up down clean logs

all: build up

build:
	docker compose -f srcs/docker-compose.yml build

up:
	docker compose -f srcs/docker-compose.yml up -d --remove-orphans

down:
	docker compose -f srcs/docker-compose.yml down --volumes --remove-orphans

clean: down
	# attention : supprime les données locales
	rm -rf $(shell sed -n 's/^HOST_DATA_DIR=//p' srcs/.env)/* || true

logs:
	docker compose -f srcs/docker-compose.yml logs -f

