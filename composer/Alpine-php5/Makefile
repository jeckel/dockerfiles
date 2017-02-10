
IMAGE ?= jeckel/composer
TAG ?= Alpine-php5

.PHONY: default build

default: build

build:
	docker build --pull --no-cache -t $(IMAGE):$(TAG) .