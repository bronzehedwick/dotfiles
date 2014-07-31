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
  if [[ -f $f ]]
  then
    echo "Linking $f to $TARGET"
    ln -s $DIR/$f $TARGET/$f
  fi
done
echo "Deleting .gitignore"
rm $TARGET/.gitignore

# Add tmux conf - based on OS
if [[ $OS == 'Darwin' ]]; then
  echo "Linking to osx version of .tmux.conf"
  ln -s $DIR/tmux.conf.osx $TARGET/.tmux.conf
else
  echo "Linking to standard *nix version of .tmux.conf"
  ln -s $DIR/tmux.conf $TARGET/.tmux.conf
fi

# If oh my zsh is install, add config
if [[ -d ~/.oh-my-zsh ]]; then
    echo "Linking bronzehedwick.zsh to .oh-my-zsh/custom/"
    ln -s bronzehedwick.zsh ~/.oh-my-zsh/custom
fi

echo "Done"
