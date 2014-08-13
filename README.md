dotfiles
========

Personal config files for Chris DeLuca

Installation
------------
1. Clone the repo
```bash
git clone git@github.com:bronzehedwick/dotfiles.git
```
2. cd into the new directory. You may also want to rename the directory with a leading dot to keep things tidy.
```bash
mv dotfiles .dotfiles && cd .dotfiles
```
3. Run the `install.sh` shell script to automatically symlink all the dotfiles in the directory to your home folder.
```bash
sh install.sh
```

Known Issues
------------
* The `install.sh` script copies in the .gitignore file; not breaking, but not clean, either.
