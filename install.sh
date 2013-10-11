#! bin/bash
# Installs dotfiles to home directory
# @author Chris DeLuca (bronzehedwick)

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
if [[ -d ~/.oh-my-zsh ]]
then
    echo "Linking bronzehedwick.zsh to .oh-my-zsh/custom/"
    ln -s bronzehedwick.zsh ~/.oh-my-zsh/custom
fi
echo "Linking git templates"
ln -s .git_template ~/.git_template
echo "Done"
