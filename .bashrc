case $- in
    *i*) ;;
    *) return;;
esac
# [ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit; };

# Set vim keybindings for movement (defaults to insert mode)
set -o vi;
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
# don't put duplicate lines or lines starting with space in the history.
# comment
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# SETUP
# WSL starts in a mounted dir - force change it to ~/
cd;
clear;
echo `date`;
LS_COLORS=$LS_COLORS:'di=0;35:tw=01;35:ow=01;35:';
export LS_COLORS;

# Allows x11 and displaying tkinter through wsl2
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1

# FUNCTIONS
function cd () { builtin cd $@ && ls; }

function today () {
    # Opens a notes file with todays date. Creates file if it does not exist
    log="/var/log/daily_tasks.log";
    notes_path="${HOME}/Documents/notes/daily_tasks/";
    cur_date=`date +%F`;
    cur_day=`date +%a`;
    cur_month=`date +%b`;
    cur_year=`date +%Y`;
    lecho "Edit request for daily log started";
    if [ $cur_day = "Mon" ]; then
        cur_week="week-$cur_date";
    else
        mon_date=`date --date='last mon' +%F`;
        cur_week="week-$mon_date";
    fi;
    cur_month_path="${notes_path}${cur_month}-${cur_year}";
    cur_week_path="${cur_month_path}/${cur_week}";
    cur_date_path="${cur_week_path}/${cur_date}";
    lecho "$cur_month - week beginning $cur_week";
    if [ ! -d $cur_month_path ]; then
        lecho "Making ${cur_month_path}";
        mkdir $cur_month_path;
    fi;
    if [ ! -d $cur_week_path ]; then
        lecho "Making ${cur_week_path}";
        mkdir $cur_week_path;
    fi;
    if [ ! -f $cur_date_path ]; then
        lecho "Adding template for today.";
        cat "${notes_path}.day_log_template" > $cur_date_path;
    fi
    lecho "Opening notes";
    vim $cur_date_path;
};

function todo () {
    vim ${HOME}/Documents/notes/daily_tasks/TODO;
};

function ssh-vim () {
    scp ~/.vimrc $1:~;
    ssh $1;
    };

function lecho () {
    if ! [[ -v log ]]; then
        echo 'Please set \$log as an environment variable before calling lecho';
        exit 1;
    fi;
    now=`date +"[%Y-%m-%d %H:%M:%S]"`;
    echo "$now $1" >> $log; 
};

function check_log () {
    cat $1 | grep -E "runtime|called" | tail -n20;
};

function myvenv () {
    source "${HOME}/venvs/$1/bin/activate";
};

function recent_files () {
    # Find the 10 most recently modified files in dir
    SEPERATOR="######################################################";
    num_files="${1:-10}";
    FILES=`find . -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -nr | cut -d" " -f5 | head -n $num_files`;
    # Flip order so cat-ting files reads from bottom to top
    FILES=`stat $FILES --format '%Y: %n' | sort -n`
    for file in $FILES;
    do
        if [ -f ${file} ]; then
            echo $SEPERATOR;
            echo ${file};
            cat ${file};
        fi;
    done;
};

function csh () {
  docker exec -it $1 bash;
}

if [ -f ".bashrc_local" ]; then
  source ".bashrc_local"
fi;

ls ~
