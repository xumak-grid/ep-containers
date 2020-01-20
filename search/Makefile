.PHONY: build run clean push binaries print

REGISTRY_NAME = 
ORG_NAME = grid
IMAGE_NAME = ep-search
IMAGE_TAG = latest
FULL_IMAGE_NAME = $(REGISTRY_NAME)/$(ORG_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)

PKG = ~/bin/EP/ext-deployment-package-710.0.0-SNAPSHOT.zip
# for development purpose solrHome-default is added inside the container
SOLR_DEFAULT = ~/ep/external-solrHome/solrHome-default

build:
	docker build -t $(FULL_IMAGE_NAME) .
run:
	docker run -d --rm --name $(IMAGE_NAME) -p 8082:8082 -e SEARCH_MEMORY=2048 $(FULL_IMAGE_NAME)
clean:
	docker stop $(IMAGE_NAME) || true
	docker rmi $(FULL_IMAGE_NAME) || true
	rm -r config database tools webapps || true
	rm -r solrHome-default || true
binaries:
	unzip -qo $(PKG) -d .
	cp -r $(SOLR_DEFAULT) ./solrHome-default
push:
	docker push $(FULL_IMAGE_NAME)
print:
	echo $(REGISTRY_NAME)/$(ORG_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)
