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

lsp_install() {
    # CSS/SASS, HTML, JSON
    npm install --global vscode-langservers-extracted
    # Python
    npm install --global pyright
    # JavaScript
    npm install --global typescript typescript-language-server
    # PHP
    npm install --global intelephense
}

lsp_update() {
    # CSS/SASS, HTML, JSON
    npm update --global vscode-langservers-extracted
    # Python
    npm update --global pyright
    # JavaScript
    npm update --global typescript typescript-language-server
    # PHP
    npm update --global intelephense
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
}

unlink() {
    cd ~/.dotfiles || exit 1
    find . -type d -depth 1 -name "[^.]*" | \
        grep -v scripts | \
        xargs basename | \
        xargs -D stow
    cd -
}

install() {
    brew_install
    tpm_install
    lsp_install
    link
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
