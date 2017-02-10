
IMAGE ?= jeckel/composer
TAG ?= Php7

.PHONY: default build

default: build

build:
	docker build --pull --no-cache -t $(IMAGE):$(TAG) .