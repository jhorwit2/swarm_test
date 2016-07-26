NAME = jhorwit2/swarm-test
VERSION = 0.0.1
PORT ?= 8085

.PHONY: all build tag_latest build run

all: build

build:
	env GOOS=linux GOARCH=amd64 go build
	docker build -t $(NAME):$(VERSION) .

run: build
	@echo "\nStarting on port $(PORT)"
	docker run -it -p $(PORT):80 $(NAME):$(VERSION)
	
tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

release: tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)
