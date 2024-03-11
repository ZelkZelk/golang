PROJECT_NAME := rust

MAKEFLAGS += --always-make

GIT_NAME := $(shell git config --get user.name)
GIT_EMAIL := $(shell git config --get user.email)

export GIT_NAME
export GIT_EMAIL

build: 
	docker compose build

install:
	docker compose up -d

clear: 
	docker compose down --remove-orphans
	docker compose rm -f

clear_all:
	docker compose down --volumes --remove-orphans --rmi local
	docker compose rm -f
	docker system prune --force

logs:
	docker compose logs -f -t

shell:
	docker compose exec -it golang bash

rebuild: clear build install

lint:
	docker compose exec -it golang gofmt -w src

syntax:
	docker compose exec -it golang go vet src/ | grep . && return 1 || return 0
	docker compose exec -it golang gofmt -d src | grep . && return 1 || return 0
	docker compose exec -it golang golint src/ | grep . && return 1 || return 0

run:
	docker compose exec -it golang go run src/main.go

compile:
	docker compose exec -it golang go build -o /bin/main src/main.go

exec:
	docker compose exec -it golang main

.SUFFIXES:
