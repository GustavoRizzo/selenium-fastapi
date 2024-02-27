#!make
include .env

# Set the project variables
BACKEND_SERVICE ?= selenium-fastapi


DOCKER=PYTHON_VERSION=${PYTHON_VERSION} docker
DOCKER_COMPOSE=PYTHON_VERSION=${PYTHON_VERSION} DJANGO_PROJECT_DIR=${DJANGO_PROJECT_DIR} COMPOSE_PROJECT_NAME=${COMPOSE_PROJECT_NAME} docker compose -f docker-compose.yml
DOCKER_COMPOSE_DEV=${DOCKER_COMPOSE} -f docker-compose-dev.yml

SERVICES ?= ${BACKEND_SERVICE}
SERVICES_DEV ?= ${BACKEND_SERVICE}-dev

NAME_CONTAINER = selenium-fastapi-selenium-fastapi-1
NAME_CONTAINER_DEV ?= selenium-fastapi-selenium-fastapi-dev-1

all: help

checkout:  ## Checkout a new source version. Using: REPO_BRANCH
	@echo "Checkout to new version"
	@git fetch; git stash; git checkout ${REPO_BRANCH}; git pull; git stash pop; cd ../

build: deploy  ## Build services images. Using: BUILD_SERVICES
	@echo "Building docker image for version ${SYSTEM_VERSION}..."
	@echo "Systems: Python [${PYTHON_VERSION}]"
	@echo "${DOCKER_COMPOSE} build ${BUILD_SERVICES}"
	@${DOCKER_COMPOSE} build ${BUILD_SERVICES}

build-dev: deploy-dev ## Build development services images. Using: BUILD_SERVICES
	@echo "Building development docker images."
	@${DOCKER_COMPOSE_DEV} build ${BUILD_SERVICES}


rebuild-dev:  ## Force a rebuild of development services images. Using: BUILD_SERVICES
	@echo "Building development docker images"
	@${DOCKER_COMPOSE_DEV} build ${BUILD_SERVICES} --no-cache

up:  ## Start containers. Using: SERVICES
	@echo "Starting containers..."
	@echo "${DOCKER_COMPOSE} up -d --force-recreate ${SERVICES}"
	@${DOCKER_COMPOSE} up -d --force-recreate ${SERVICES}

up-dev:  ## Start development containers. Using: SERVICES_DEV
	@echo "Starting development containers"
	@echo "${DOCKER_COMPOSE_DEV} up -d --force-recreate ${SERVICES_DEV}"
	@${DOCKER_COMPOSE_DEV} up -d --force-recreate ${SERVICES_DEV}

restart-dev:  ## Restart services (or one service specified). Using: SERVICES_DEV
	@${DOCKER_COMPOSE_DEV} restart ${SERVICES_DEV}

stop-dev:  ## Restart service service. Using: SERVICES_DEV
	@${DOCKER_COMPOSE_DEV} stop ${SERVICES_DEV}

run_script_save_printscreen_page:
	@echo "Running script to save printscreen page"
	@docker exec -it ${NAME_CONTAINER_DEV} python ./scripts/save_printscreen_page.py

run_script_save_printscreen_page-dev:
	@echo "Running script to save printscreen page on development environment"
	@docker exec -it ${NAME_CONTAINER_DEV} python ./scripts/save_printscreen_page.py

version:  ## Get version
	@$(eval SYSTEM_VERSION = $(shell git describe --tag --dirty=-local-changes --always))
	@$(eval PYTHON_VERSION = $(shell cat ./.python-version))
	@echo "${SYSTEM_VERSION}" > ./.version
	@sed -i -e "s|^SYSTEM_VERSION=.*|SYSTEM_VERSION=${SYSTEM_VERSION}|" ./.env
	@sed -i -e "s|^PYTHON_VERSION=.*|PYTHON_VERSION=${PYTHON_VERSION}|" ./.env
	@echo "Systems Versions: System ${SYSTEM_VERSION} Python ${PYTHON_VERSION}"

help:  ## Show this help
	@echo "\nAvailable commands:"
	@echo
	@sed -n -E -e 's|^([a-zA-Z|\d\_-]+):.+## (.+)|\1@\2|p' $(MAKEFILE_LIST) | column -s '@' -t
	@echo
