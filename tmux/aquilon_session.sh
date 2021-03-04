#!/bin/bash

SESSIONNAME="CLOUD";
tmux has-session -t $SESSIONNAME 2> /dev/null;

if [ $? != 0 ]; then
    TMUX='' tmux new-session -d -s $SESSIONNAME -n 'Aquilon';
    tmux set -g pane-border-status bottom;
    tmux send-keys 'ssh aquilon' C-m;
    tmux split-window -h;
    tmux send-keys 'ssh aquilon' C-m;
    # Second window for machines to test on
    tmux new-window -n 'Machines';
    tmux split-window -v -p 50;
    tmux split-window -h -p 50;
    tmux select-pane -t 1;
    tmux split-window -b -h -p 50;
fi
if [[ -z "$TMUX" ]]; then
    tmux -2 attach-session -t $SESSIONNAME;
else
    tmux switch-client -t "$SESSIONNAME";
fi;
