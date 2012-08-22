dotfiles
========

Personal config files for Chris DeLuca

Installation
-------
# Clone the repo 
```shell
clone git@github.com:bronzehedwick/dotfiles.git 
```
# cd into the new directory. You may also want to rename the directory with a leading dot to keep things tidy.
```shell
mv dotfiles .dotfiles && cd .dotfiles
```
# Run the link_dotfiles.sh shell script to automatically symlink all the dotfiles in the directory to your home folder.
```shell
sh link_dotfiles.sh
```

Known Issues
-------
# The link_dotfiles.sh script copies in the .gitignore file; not breaking, but not clean, either.
