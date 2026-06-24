IMAGE_NAME ?= code-to-cloud-lab
TAG        ?= local
PORT       ?= 8080
 
.PHONY: lint build run push clean
 
lint:
		docker run --rm -v $(PWD):/app hadolint/hadolint hadolint /app/Dockerfile || true
 
build: lint                       # lint first, then build
		docker build -t $(IMAGE_NAME):$(TAG) .
 
run:                              # verify it starts locally with compose
		docker compose up -d
 
push:
		docker push $(IMAGE_NAME):$(TAG)
 
clean:
		-docker compose down            # - ignore errors; no failure if no container exists
