VERSION=$(shell cat VERSION)
OS=$(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(shell uname -m)

release:
		shards build --production
		mkdir -p releases
		gzip -c bin/gsub > releases/gsub-$(VERSION)_$(OS)_$(ARCH).gz

.PHONY: release
