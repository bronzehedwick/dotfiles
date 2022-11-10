#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

ARCH="$(arch)"
if [ "$ARCH" == "arm64" ]; then
    brew_path=/opt/homebrew/bin
else
    brew_path=$brew_path
fi

_valid_commands() {
    echo -e "Valid commands:\n\t-h|--help"
    for command in $command_list
    do
        echo -e "\t$command"
    done
}

mail_init() {
    # Add the Mail directory if it doesn't already exist.
    mkdir -p $HOME/.local/share/neomutt/mailbox/chris
    mkdir -p $HOME/.local/share/neomutt/mailbox/lullabot
    # Sync mail from IMAP.
    $brew_path/mbsync --all
    # Do initial mail indexing.
    $brew_path/notmuch new
}

mail_sync() {
    # Sync mail from IMAP.
    $brew_path/mbsync --all
    # Do indexing.
    $brew_path/notmuch new
    # Generate recent sent and archive folders.
    # $brew_path/mu find --clearlinks --format=links --linksdir=~/$HOME/.local/share/neomutt/mailbox/ RArchive date:3m.. maildir:'/Archive'
    # $brew_path/mu find --clearlinks --format=links --linksdir=~/$HOME/.local/share/neomutt/mailbox/ ReSent date:3m.. maildir:'/Sent'
}

lsp_install() {
    # CSS/SASS, HTML, JSON
    npm install --global vscode-langservers-extracted
    # Python
    npm install --global pyright
    # JavaScript
    npm install --global typescript typescript-language-server
    # PHP
    if [ ! -d ~/Documents/phpactor ]; then
        cd ~/Documents || exit 1
        git clone git@github.com:phpactor/phpactor
    fi
    cd ~/Documents/phpactor || exit 1
    composer install
    ln -s ~/Documents/phpactor/bin/phpactor $brew_path/phpactor
    phpactor status
}

lsp_update() {
    # CSS/SASS, HTML, JSON
    npm update --global vscode-langservers-extracted
    # Python
    npm update --global pyright
    # JavaScript
    npm update --global typescript typescript-language-server
    # PHP
    cd ~/Documents/phpactor || exit 1
    composer update
    phpactor status
}

tpm_install() {
    mkdir -p ~/.dotfiles/tmux/.config/tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.dotfiles/tmux/.config/tmux/plugins/tpm
}

brew_install() {
    if ! command -v brew &> /dev/null
    then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew bundle install --file ~/.dotfiles/Brewfile
}

link() {
    cd ~/.dotfiles || exit 1
    find . -type d -depth 1 -name "[^.]*" | \
        grep -v scripts | \
        xargs basename | \
        xargs stow
    cd -
    launchctl load -w ~/Library/LaunchAgents/local.mailsync.plist
    launchctl load -w ~/Library/LaunchAgents/local.switch-theme.plist
}

unlink() {
    cd ~/.dotfiles || exit 1
    find . -type d -depth 1 -name "[^.]*" | \
        grep -v scripts | \
        xargs basename | \
        xargs -D stow
    cd -
    launchctl unload -w ~/Library/LaunchAgents/local.mailsync.plist
    launchctl unload -w ~/Library/LaunchAgents/local.switch-theme.plist
}

mail_setup() {
    mail_init
    mail_sync
}

install() {
    brew_install
    tpm_install
    lsp_install
    link
}

all() {
    install
    mail_setup
}

# Dynamically fetch all the functions in this file.
func_list="$(compgen -A function)"
command_list="$(echo "$func_list"|grep -v '^_')"

# Show the command help if there's no arguments to operate on.
if [ $# -eq 0 ]
then
    echo -e "Error: No arguments\n"
    _valid_commands
    exit 1
fi

# Show help if asked for with a flag.
if [ "$1" = "-h" ] || [ "$1" = "--help" ]
then
    _valid_commands
    exit 0
fi

if echo "$command_list"|grep -w "$1" > /dev/null
then
    func_call="$1"
    $func_call
else
    echo -e "Error: Not a valid command\n"
    _valid_commands
    exit 2
fi

# vim: shiftwidth=4 expandtab foldmethod=marker
