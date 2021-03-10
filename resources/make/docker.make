PHONY=nginx-cli php-cli docker-compose-ok up down nginx-log php-log

DOCKER_RUN=
DOCKER_COMPOSE=docker-compose
DC=${DOCKER_COMPOSE}
DOCKER_COMPOSE_EXEC=${DC} exec
EXEC=${DOCKER_COMPOSE_EXEC}

.PHONY: ${PHONY}

docker-compose-ok: docker-compose.yml
	@echo "Project name:" ${COMPOSE_PROJECT_NAME}

services-is-up: docker-compose-ok
	@${DC} ps nginx-actions php-actions

nginx-log: docker-compose-ok
	$(info Nginx stdout logs)
	${DC} logs -f nginx-actions

php-log: docker-compose-ok
	$(info Php-fpm stdout logs)
	${DC} logs -f php-actions

nginx-cli: docker-compose-ok
	$(info Enter nginx service console)
	${EXEC} nginx-actions sh

php-cli: docker-compose-ok
	$(info Enter php service console)
	${EXEC} php-actions bash

up: docker-compose-ok
	$(info Start ${COMPOSE_PROJECT_NAME} service)
	${DC} up -d --force-recreate --build

down: docker-compose-ok
	$(info Down ${COMPOSE_PROJECT_NAME} service)
	${DC} down

status:
	@$(DOCKER_COMPOSE) ps nginx-actions php-actions
