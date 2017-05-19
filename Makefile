VERSION=$(shell cat VERSION)
OS=$(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(shell uname -m)
SOURCES=$(wildcard src/*.cr src/**/*.cr)

dev: bin/gsub

bin/gsub: $(SOURCES)
	shards build

release:
	shards build --production
	mkdir -p releases
	tar -czvf releases/gsub-$(VERSION)_$(OS)_$(ARCH).tar.gz bin/gsub

install:
	shards build --production
	cp bin/gsub /usr/local/bin

.PHONY: release
