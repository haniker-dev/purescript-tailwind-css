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

run-cli-test: ## Run cli to ./gen-test folder
	./cli/purs-tailwind-css-dev.js --config ./test/tailwind.config.js \
		--output ./gen-test \
		--input ./test/Fixture/full.css \
		--target none
	./cli/purs-tailwind-css-dev.js --config ./test/tailwind.config.js \
		--output ./gen-test \
		--input ./test/Fixture/simple.css \
		--module-name TailwindHalogen \
		--target halogen

run-cli-local: ## Run cli to ./gen-local folder which is git ignored
	./cli/purs-tailwind-css-dev.js --config ./test/tailwind.config.js --output ./gen-local
