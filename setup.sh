#!/bin/bash

FILES=(
    ".bashrc"
    ".bash_aliases"
    ".vimrc"
    ".tmux.conf"
    ".tmux.conf.local"
    ".kubectl_aliases"
    ".kubectl_local"
    )

old_path="${HOME}/dotfiles/old_dots";

if [ ! -d "$old_path" ]; then
    echo "Making $old_path"
    mkdir "$old_path";
fi;

for file in ${FILES[*]}; do
    echo "On $file";
    # Moves existing files - leaves symlinks in place
    if [ -h "${HOME}/${file}" ]; then
        echo "${HOME}/${file} is a symlink. Unlinking";
        unlink "${HOME}/${file}"
    elif [ -f "${HOME}/${file}" ]; then
        echo "$file is a regular file in $HOME. Moving to $old_path";
        mv "${HOME}/${file}" ${HOME}/dotfiles/old_dots/ && echo "Moved ${file} to old_dots";
    fi;
    echo "symlinking ${HOME}/dotfiles/${file} to ${HOME}/${file}";
    ln -sv "${HOME}/dotfiles/$file" "${HOME}/$file";
done;
echo "Done";
