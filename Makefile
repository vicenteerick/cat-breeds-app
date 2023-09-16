#!make
include .env
export $(shell sed 's/=.*//' .env)

help: ## Show this help.
	@echo "  Usage:\n    \033[36m make <target>\n\n \033[0m Targets:"
	@grep -E '^[a-zA-Z_-]+:.?##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "     \033[36m%-30s\033[0m %s\n", $$1, $$2}'


setup: ## Install all tools
	@make setup_tools


setup_tools: \
	install_homebrew \
	install_swiftlint \
	install_sourcery \
	config_sourcery \

install_homebrew: ## Check if Homebrew is installed, otherwise install it
	@chmod +x "./Script/install_homebrew.sh"
	@./Script/install_homebrew.sh

install_swiftlint: ## Install swiftlint
	@echo "Installing swiftlint..."
	@brew install swiftlint
	@chmod +x "./Script/swiftlint.sh"
	@./Script/swiftlint.sh

install_sourcery: ## Install sourcery
	@echo "Installing sourcery..."
	@brew install sourcery
	@echo "Sourcery installed."
	@sourcery --config ".sourcery.yml"
	@echo "Sourcery configured."

config_sourcery: ## Install sourcery
	@echo "Configuring sourcery..."
	@sourcery --config ".sourcery.yml"
	@echo "Sourcery configured."