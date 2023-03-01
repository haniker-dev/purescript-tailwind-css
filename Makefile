.PHONY: help
help:
	@echo 'usage: make [target]'
	@echo
	@echo 'List of targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

FORCE: # Used as a way to force certain receipe to always run

build: FORCE ## Build the app locally
	spago build

rebuild: FORCE ## Rebuild the app locally
	rm -rf output
	spago build

run-test: ## Run test locally
	spago test

run-cli: ## Run cli locally
	./cli/purs-tailwind-css-dev.js --output ./test-generated
