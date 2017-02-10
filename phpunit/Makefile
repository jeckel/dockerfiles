
IMAGE ?= jeckel/phpunit
TAG ?= latest

.PHONY: default build

default: build

build:
	docker build --pull --no-cache -t $(IMAGE):$(TAG) .