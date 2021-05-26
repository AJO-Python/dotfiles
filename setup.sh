#!/bin/bash
echo "synkinking .bash_aliases, .bashrc, .vimrc, tmux to ~"
ln -sv .bash_aliases ~
ln -sv .bashrc ~
ln -sv .vimrc ~
ln -sb tmux ~
echo "Done"
