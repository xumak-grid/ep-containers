.PHONY: build clean

REGISTRY_NAME = xk
IMAGE_NAME = tomcat7
IMAGE_TAG = latest
FULL_IMAGE_NAME = $(REGISTRY_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)

build:
	docker build -t $(FULL_IMAGE_NAME) .
clean:
	docker rmi $(FULL_IMAGE_NAME) || true
