#!/bin/sh

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
