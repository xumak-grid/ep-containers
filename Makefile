.PHONY: build clean clean-dangling push run

# EP deployment package to use in the build
PKG = ~/bin/EP/ext-deployment-package-710.0.0-SNAPSHOT.zip

# for development purpose solrHome-default is added inside the container
SOLR_DEFAULT = ~/ep/external-solrHome/solrHome-default

build:
	ls $(PKG)
	ls $(SOLR_DEFAULT)
	cd activemq; make build
	cd batch; make binaries build
	cd cm; make binaries build
	cd cortex; make binaries build
	cd integration; make binaries build
	cd search; make binaries build
clean: clean-dangling
	cd activemq; make clean
	cd batch; make clean
	cd cm; make clean
	cd cortex; make clean
	cd integration; make clean
	cd search; make clean
clean-dangling:
	docker rmi $$(docker images --filter dangling=true -q) || true

# Caution! Caution! Pushing images to registry will override them
# Please make sure you want this
push:
	cd activemq; make push
	cd batch; make push
	cd cm; make push
	cd cortex; make push
	cd integration; make push
	cd search; make push
run:
	docker-compose up -d
