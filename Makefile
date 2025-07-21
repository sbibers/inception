# colors
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
CYAN = \033[0;36m
NC = \033[0m

COMPOSE_FILE = ./srcs/docker-compose.yml
ENV_FILE = ./srcs/.env
DATA_DIR = /home/sbibers/data

all: up

# start everything
up:
	@if [ ! -f $(ENV_FILE) ]; then \
        echo "$(RED)❌ Error: .env file is missing at $(ENV_FILE)$(NC)"; \
        exit 1; \
	fi
	@echo "$(CYAN)Starting Inception project ...$(NC)"
	@sudo mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	@docker compose -f $(COMPOSE_FILE) up --build -d
	@echo "$(GREEN)✅ Project is running!$(NC)"
	@echo "$(YELLOW)WordPress: https://localhost$(NC)"
	@echo "$(YELLOW)Admin: https://localhost/wp-admin$(NC)"

# stop everything
down:
	@echo "$(YELLOW)Stopping containers ...$(NC)"
	@docker compose -f $(COMPOSE_FILE) down
	@echo "$(GREEN)✅ Stopped$(NC)"

# restart without delete anything
restart:
	@make down
	@make up

# check status
status:
	@echo "$(CYAN)📊 Container Status:$(NC)"
	@docker compose -f $(COMPOSE_FILE) ps
	@echo "$(CYAN)=== Networks ====$(NC)"
	@docker network ls
	@echo "$(CYAN)=== Volumes ====$(NC)"
	@docker volume ls
	@echo "$(CYAN)🌐 Access URLs:$(NC)"
	@echo "$(GREEN)WordPress: https://localhost$(NC)"
	@echo "$(GREEN)WordPress Admin: https://localhost/wp-admin$(NC)"
	@echo "$(GREEN)Alternative: https://sbibers.42.fr$(NC)"

# show logs of all services
logs:
	@docker compose -f $(COMPOSE_FILE) logs -f

logs-nginx:
	@docker logs nginx -f

logs-wordpress:
	@docker logs wordpress -f

logs-mariadb:
	@docker logs mariadb -f

# access containers
nginx:
	@docker exec -it nginx bash

wordpress:
	@docker exec -it wordpress bash

mariadb:
	@docker exec -it mariadb bash

# clean up project data
clean:
	@echo "$(YELLOW)Cleaning up ...$(NC)"
	@docker compose -f $(COMPOSE_FILE) down -v
	@docker system prune -f
	@sudo rm -rf $(DATA_DIR)
	@echo "$(GREEN)✅ Clean$(NC)"

# full clean - remove all data and volumes
fclean: clean
	@echo "$(RED)⚠️  Full cleanup - this removes ALL docker data!$(NC)"
	@docker compose -f $(COMPOSE_FILE) down -v --remove-orphans
	@docker system prune -af --volumes
	@sudo rm -rf $(DATA_DIR)
	@echo "$(GREEN)✅ Everything cleaned$(NC)"

# rebuild everything
re: fclean up

# start and stop containers
start:
	@docker compose -f $(COMPOSE_FILE) start

stop:
	@docker compose -f $(COMPOSE_FILE) stop

# show all rules and commands
help:
	@echo "$(CYAN)Inception Project Commands:$(NC)"
	@echo ""
	@echo "$(GREEN)Basic:$(NC)"
	@echo "  make up       - Start the project"
	@echo "  make down     - Stop the project"
	@echo "  make restart  - Restart everything"
	@echo "  make status   - Show container status"
	@echo ""
	@echo "$(GREEN)Logs:$(NC)"
	@echo "  make logs            - All logs"
	@echo "  make logs-nginx      - Nginx logs only"
	@echo "  make logs-wordpress  - WordPress logs only"
	@echo "  make logs-mariadb    - MariaDB logs only"
	@echo ""
	@echo "$(GREEN)Access:$(NC)"
	@echo "  make nginx     - Enter nginx container"
	@echo "  make wordpress - Enter wordpress container"
	@echo "  make mariadb   - Enter mariadb container"
	@echo ""
	@echo "$(GREEN)Cleanup:$(NC)"
	@echo "  make clean   - Clean project data"
	@echo "  make fclean  - Clean everything"
	@echo "  make re      - Clean and rebuild"
	@echo ""
	@echo "$(GREEN)Other:$(NC)"
	@echo "  make help    - This help"

.PHONY: all up down restart status logs logs-nginx logs-wordpress logs-mariadb nginx wordpress mariadb clean fclean re start stop help