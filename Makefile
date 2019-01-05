PROGRAMS = $(shell find . -type d -depth 1 -name "[^.]*"|grep -v scripts|xargs basename)
OS = $(shell uname -s)
HAS_BREW = $(shell command -v brew >/dev/null 2>&1 || false)
BREW_INSTALL = $(shell curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)

default: help

help: ## Prints help for targets with comments
	@grep -E '^[a-zA-Z._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

link: ## Link all program configuration via GNU stow.
	@echo $(PROGRAMS) | xargs stow

unlink: ## Remove links to all program configuration via GNU stow.
	@echo $(PROGRAMS) | xargs -D stow

programs: ## Installs all programs listed in programs.txt.
	@$(HAS_BREW) || { /usr/bin/ruby -e $(BREW_INSTALL) }
	@cat ./programs.txt | xargs brew install

vim-plugins: ## Installs/updates vim plugins defined in vim-plugins.txt.
	@./scripts/vim-plugins.sh

mail: ## Syncronizes all mail locally to ~/Mail.
	@./scripts/mailsync.sh

caldav: ## Syncronizes all contacts and calendars.
	@vdirsyncer sync

all: programs link vim-plugins mail
