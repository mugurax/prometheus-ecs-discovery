DOCKER_HUB_USERNAME ?= mugurax

GIT_HOST ?= github.org
GIT_TEAM ?= mugurax
PROJECT_CODE ?= monitoring-stack

# versioning strategy: branch-commit
# we might want to have diff strategies for api-servers (semver) vs processors
GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD 2> /dev/null)
GIT_COMMIT ?= $(shell git rev-parse --short HEAD 2> /dev/null)
APP_VERSION ?= $(GIT_BRANCH)-$(GIT_COMMIT)

DOCKER_IMAGE ?= $(DOCKER_HUB_USERNAME)/$(PROJECT_CODE)-$(APP_NAME):$(APP_VERSION)

.DEFAULT_GOAL := all

.PHONY : all
all :  

.PHONY: prom
image: APP_NAME = prometheus-ecs-sd
      DOCKER_IMAGE = $(DOCKER_HUB_USERNAME)/$(PROJECT_CODE)-$(APP_NAME):$(APP_VERSION)
image:
	@echo "# Building <$@> ${DOCKER_IMAGE} from $(GIT_BRANCH)"
	@docker build -t $(DOCKER_IMAGE) . 

push: APP_NAME = prometheus-ecs-sd
push:
	@echo "pushing ${DOCKER_IMAGE} to docker.io"
	@docker push ${DOCKER_IMAGE}

