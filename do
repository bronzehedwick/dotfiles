#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

_valid_commands() {
    echo -e "Valid commands:\n\t-h|--help"
    for command in $command_list
    do
        echo -e "\t$command"
    done
}

mail_init() {
    # Add the Mail directory if it doesn't already exist.
    /usr/local/bin/mu mkdir ~/Mail
    # Sync mail from IMAP.
    /usr/local/bin/mbsync chris
    # Do initial mail indexing.
    /usr/local/bin/mu init --maildir ~/Mail \
        --my-address iam@chrisdeluca.me \
        --my-address contact@chrisdeluca.me \
        --my-address code@chrisdeluca.me \
        --my-address christopher.j.deluca@gmail.com \
        --my-address bronzehedwick@gmail.com \
        --my-address signups@chrisdeluca.me
    # Initial index.
    /usr/local/bin/mu index
}

mail_sync() {
    # Sync mail from IMAP.
    /usr/local/bin/mbsync chris
    # Do indexing.
    /usr/local/bin/mu index --lazy-check
}

lsp_install() {
    # CSS/SASS, HTML, JSON
    npm install --global vscode-langservers-extracted
    # Python
    npm install --global pyright
    # JavaScript
    npm install --global typescript typescript-language-server
    # PHP
    cd ~/Documents || exit 1
    git clone git@github.com:phpactor/phpactor
    cd phpactor || exit 1
    composer install
    ln -s ~/Documents/phpactor/bin/phpactor /usr/local/bin/phpactor
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
