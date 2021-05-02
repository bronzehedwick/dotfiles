PROGRAMS = $(shell find . -type d -depth 1 -name "[^.]*"|grep -v scripts|xargs basename)
OS = $(shell uname -s)

default: help

help: ## Prints help for targets with comments.
	@grep -E '^[a-zA-Z._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

tmux: ## Installs tmux plugin manager.
	@mkdir -p ~/.dotfiles/tmux/.config/tmux/plugins && git clone https://github.com/tmux-plugins/tpm ~/.dotfiles/tmux/.config/tmux/plugins/tpm

link: ## Link all program configuration via GNU stow.
	@echo $(PROGRAMS) | xargs stow

unlink: ## Remove links to all program configuration via GNU stow.
	@echo $(PROGRAMS) | xargs -D stow

brew: ## Installs packages in Brewfile.
	@brew bundle

mailinit: ## Initializes first mail run to ~/Mail.
	@./scripts/mailinit.sh

mail: ## Syncronizes all mail locally to ~/Mail.
	@./scripts/mailsync.sh

all: brew link tmux mail caldav

# vim: nolist
