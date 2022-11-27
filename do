#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

ARCH="$(arch)"
if [ "$ARCH" == "arm64" ]; then
    BREW_PATH=/opt/homebrew/bin
else
    BREW_PATH=/usr/local/bin
fi

MAIL_PATH="$HOME/.local/share/neomutt/mailbox"

_valid_commands() {
    echo -e "Valid commands:\n\t-h|--help"
    for command in $command_list
    do
        echo -e "\t$command"
    done
}

mail_init() {
    # Add the Mail directory if it doesn't already exist.
    mkdir -p "$MAIL_PATH/chris"
    mkdir -p "$MAIL_PATH/lullabot"
    # Sync mail from IMAP.
    $BREW_PATH/mbsync --all
    # Do initial mail indexing.
    $BREW_PATH/notmuch new --quiet
    # Tag folders.
    while read -r dir; do
        $BREW_PATH/notmuch tag +home -- folder:"$dir"
    done < <(find "$MAIL_PATH/chris" -type d -depth 1 -print0)
    while read -r dir; do
        $BREW_PATH/notmuch tag +lullabot -- folder:"$dir"
    done < <(find "$MAIL_PATH/lullabot" -type d -depth 1 -print0)
    $BREW_PATH/notmuch tag +inbox -- folder:"chris/INBOX"
    $BREW_PATH/notmuch tag +inbox -- folder:"lullabot/[Gmail]/INBOX"
    $BREW_PATH/notmuch tag -inbox +sent -- folder:"chris/Sent"
    $BREW_PATH/notmuch tag -inbox +sent -- folder:"lullabot/[Gmail]/Sent Mail"
    $BREW_PATH/notmuch tag -inbox +archive -- folder:"chris/Archive"
    $BREW_PATH/notmuch tag -inbox +archive -- folder:"lullabot/[Gmail]/All Mail"
    $BREW_PATH/notmuch tag -inbox +trash -- folder:"chris/Trash"
    $BREW_PATH/notmuch tag -inbox +trash -- folder:"lullabot/[Gmail]/Trash"
    $BREW_PATH/notmuch tag -inbox +draft -- folder:"chris/Drafts"
    $BREW_PATH/notmuch tag -inbox +draft -- folder:"lullabot/[Gmail]/Drafts"
}

mail_sync() {
    # Run only if not already running in other instance.
    pgrep mbsync >/dev/null && { echo "mbsync is already running."; exit ;}
    # Re-tag moved messages.
    $BREW_PATH/notmuch tag +archive -index -unread -- folder:"chris/Archive"
    $BREW_PATH/notmuch tag +archive -index -unread -- folder:"lullabot/[Gmail]/All Mail"
    # Sync mail from IMAP.
    $BREW_PATH/mbsync --all --quiet
    # Hack to delete dumb extra folder.
    rm -r "$MAIL_PATH/chris/~"
    # Do indexing.
    $BREW_PATH/notmuch new --quiet
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
    ln -s ~/Documents/phpactor/bin/phpactor $BREW_PATH/phpactor
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
