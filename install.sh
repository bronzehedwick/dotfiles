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
echo "Done"
