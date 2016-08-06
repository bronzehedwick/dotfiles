#! bin/bash
# Installs dotfiles to home directory
# @author Chris DeLuca (bronzehedwick)

# Add dotfiles
OS="$(uname)"
FILES=.*
TARGET=$HOME
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
for f in $FILES
do
  if [[ -f $f ]]; then
    # Skip files if they already exist
    if [[ -f $TARGET/$f ]]; then
      continue
    fi
    # Ignore linking .gitignore
    if [[ $f == '.gitignore' ]]; then
      continue
    fi
    # Link the files
    echo "Linking $f to $TARGET"
    ln -s $DIR/$f $TARGET/$f
  fi
done

# Add oh my fish config
if [[ -d ~/.local/share/omf ]]; then
  echo "Removing empty custom omf scaffolding directory"
  rm -rf $TARGET/.config/omf
  echo "Linking omf to ~/.config/omf"
  ln -s $DIR/omf $TARGET/.config/omf
fi

# Add weechat (irc) config
echo "Linking weechat config"
ln -s $DIR/weechat $TARGET/.weechat

# Install VimPlug
if [[ ! -d ~/.config/nvim/autoload ]]; then
  echo "Installing VimPlug"
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Add NeoVim config
if [[ ! -f $TARGET/.config/nvim/init.vim ]]; then
  echo "Linking NeoVim config"
  ln -s $DIR/nvim/init.vim $TARGET/.config/nvim/init.vim
fi

# Install NeoVim plugins
echo "Installing NeoVim plugins..."
nvim +PlugInstall +qa

echo "Done"
