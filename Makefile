PROGRAMS = $(shell find . -type d -depth 1 -name "[^.]*"|xargs basename)

all: help

help: ## Prints help for targets with comments
	@grep -E '^[a-zA-Z._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

link: ## Link all program configuration via GNU stow.
	@echo $(PROGRAMS) | xargs stow

unlink: ## Remove links to all program configuration via GNU stow.
	@echo $(PROGRAMS) | xargs -D stow
