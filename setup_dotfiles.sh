#!/bin/bash

########## Variables

dir=$(pwd)/dotfiles                   # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files=".bashrc"        # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file

    echo "Now source $file"
    source ~/$file
done

# now copy the ipython configuration files
echo "Now backin up Ipython profile "
mv ~/.ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py.bak

echo "Creating symlink to Ipython profile"
ln -s $dir/ipython_config.py ~/.ipython/profile_default/ipython_config.py

echo "All done"