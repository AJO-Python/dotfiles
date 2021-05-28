#!/bin/bash

FILES=(
    ".bashrc"
    ".bash_aliases"
    ".vimrc"
    ".tmux.conf"
    ".tmux.conf.local"
    )

old_path="$HOME/dotfiles/old_dots";

if ! [ -d "$old_path" ]; then
    echo "Making $old_path"
    mkdir "$old_path";
fi;

for file in ${FILES[*]}; do
    echo "On $file";
    # Moves existing files - leaves symlinks in place
    if [ -f "$file" ]; then
        mv $file $HOME/dotfiles/old_dots/ && echo "Moved $file to old_dots";
    fi;
    echo "symlinking $file to $HOME";
    ln -sv $HOME/dotfiles/$file $HOME/$file
done;
echo "Done";
