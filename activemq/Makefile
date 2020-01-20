.PHONY: build run clean push print

REGISTRY_NAME = 
ORG_NAME = grid
IMAGE_NAME = ep-activemq
IMAGE_TAG = 5.14.3
FULL_IMAGE_NAME = $(REGISTRY_NAME)/$(ORG_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)

build:
	docker build -t $(FULL_IMAGE_NAME) .
run:
	docker run -d --rm --name $(IMAGE_NAME) -p 61616:61616 -p 8161:8161 $(FULL_IMAGE_NAME)
clean:
	docker stop $(IMAGE_NAME) || true
	docker rmi $(FULL_IMAGE_NAME) || true
push:
	docker push $(FULL_IMAGE_NAME)
print:
	echo $(REGISTRY_NAME)/$(ORG_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)
