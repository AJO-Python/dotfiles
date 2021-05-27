#!/bin/bash

old_path="/home/josh/dotfiles/old_dots";

echo "Moving old files to /dotfiles/old_dots"
if ! [ -d "$old_path" ]; then
    echo "Trying to make $old_path"
    mkdir "$old_path";
fi;

cd ~;
for file in .bashrc .bash_aliases .vimrc tmux;
do
    echo "On $file";
    if [ -L "$file" ] || [ -d "$file" ]; then
        mv $file ~/dotfiles/old_dots/ && echo "Moved $file to old_dots";
    fi;
done;

echo "symlinking .bash_aliases, .bashrc, .vimrc, tmux to ~";
ln -sv /home/josh/dotfiles/.bash_aliases /home/josh/.bash_aliases;
ln -sv /home/josh/dotfiles/.bashrc /home/josh/.bashrc;
ln -sv /home/josh/dotfiles/.vimrc /home/josh/.vimrc;
ln -sb /home/josh/dotfiles/tmux /home/josh/tmux;
echo "Done";
