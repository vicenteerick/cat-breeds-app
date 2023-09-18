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
	install_mint \
	install_mint_packages \
	config_sourcery \

install_homebrew: ## Check if Homebrew is installed, otherwise install it
	@chmod +x "./Script/install_homebrew.sh"
	@./Script/install_homebrew.sh

install_mint: ## Install Mint
	@echo "Installing Mint..."
	@brew install mint
	@echo "Mint installed."

install_mint_packages: ## Install Mint Packages
	@echo "Installing Mint Packages..."
	@mint bootstrap
	@echo "Mint Packages installed."

config_sourcery: ## Install sourcery
	@echo "Configuring sourcery..."
	@mint run sourcery --config ".sourcery.yml"
	@echo "Sourcery configured."