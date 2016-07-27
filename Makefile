NAME = jhorwit2/swarm-test
VERSION = 0.0.1
PORT ?= 8085
EXISTS=`docker images $(NAME):$(VERSION) -q`

.PHONY: all build tag_latest build run

all: build

build:
	env GOOS=linux GOARCH=amd64 go build
	docker build -t $(NAME):$(VERSION) .

run: build
	@echo "\nStarting on port $(PORT)"
	docker run -it -p $(PORT):80 $(NAME):$(VERSION)
	
tag_latest: build
	@if [ "$(docker images -q $(NAME):$(VERSION) 2> /dev/null)" != "" ]; then echo "$(NAME):$(VERSION) already is tag"; false; fi
	docker tag $(NAME):$(VERSION) $(NAME):$(VERSION)

release: tag_latest
	@if [ "$(docker images -q $(NAME):$(VERSION) 2> /dev/null)" != "" ]; then echo "$(NAME):$(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME):$(VERSION)
