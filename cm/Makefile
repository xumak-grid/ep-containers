.PHONY: build run clean push binaries print

REGISTRY_NAME = 
ORG_NAME = grid
IMAGE_NAME = ep-cm
IMAGE_TAG = latest
FULL_IMAGE_NAME = $(REGISTRY_NAME)/$(ORG_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)

PKG = ~/bin/EP/ext-deployment-package-710.0.0-SNAPSHOT.zip

build:
	docker build -t $(FULL_IMAGE_NAME) .
run:
	docker run -d --rm --name $(IMAGE_NAME) -p 8086:8080 -e CM_MEMORY=2048 $(FULL_IMAGE_NAME)
clean:
	docker stop $(IMAGE_NAME) || true
	docker rmi $(FULL_IMAGE_NAME) || true
	rm -r config database tools webapps || true
binaries:
	unzip -qo $(PKG) -d .
push:
	docker push $(FULL_IMAGE_NAME)
print:
	echo $(REGISTRY_NAME)/$(ORG_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)
