VERSION=$(shell cat VERSION)
OS=$(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(shell uname -m)

release:
		shards build --production
		mkdir -p releases
		tar -czvf releases/gsub-$(VERSION)_$(OS)_$(ARCH).tar.gz bin/gsub

.PHONY: release
