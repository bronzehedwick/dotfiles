#! bin/bash
# Installs dotfiles to home directory
# @author Chris DeLuca (bronzehedwick)

# Add dotfiles
OS="$(uname)"
FILES=.*
TARGET=~
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

# Add tmux conf - based on OS
if [[ ! -f $TARGET/.tmux.conf ]]; then
  if [[ $OS == 'Darwin' ]]; then
    echo "Linking to osx version of .tmux.conf"
    ln -s $DIR/tmux.conf.osx $TARGET/.tmux.conf
  else
    echo "Linking to standard *nix version of .tmux.conf"
    ln -s $DIR/tmux.conf $TARGET/.tmux.conf
  fi
fi

# If oh my zsh is installed, add config
if [[ ! -f ~/.oh-my-zsh/custom/bronzehedwick.zsh ]]; then
  if [[ -d ~/.oh-my-zsh ]]; then
    echo "Linking bronzehedwick.zsh to .oh-my-zsh/custom/"
    ln -s bronzehedwick.zsh ~/.oh-my-zsh/custom
  fi
fi

# If oh my fish is installed, add config
if [[ ! -f ~/.oh-my-fish/custom/bronzehedwick.load ]]; then
  if [[ -d ~/.oh-my-fish ]]; then
    echo "Linking bronzehedwick.load to .oh-my-fish/custom/"
    ln -s bronzehedwick.load ~/.oh-my-fish/custom
  fi
fi

echo "Done"
