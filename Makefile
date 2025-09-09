all: up

up:
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb
	docker-compose -f docker-compose.yml up -d --build

down:
	docker-compose -f docker-compose.yml down

clean: down
	docker system prune -af

fclean: clean
	docker volume prune -f
	sudo rm -rf /home/$(USER)/data

re: fclean all

.PHONY: all up down clean fclean re
