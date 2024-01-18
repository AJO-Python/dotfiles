# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
# start tmux on new terminal instance
[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit;};

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=-1
HISTFILESIZE=-1
HISTTIMEFORMAT="[%F %T] "
HISTFILE="${HOME}/.bash_eternal_history"
touch $HISTFILE
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# FUNCTIONS
#function cd () { builtin cd "$@" && ls; }

function today () {
    # Opens a notes file with todays date. Creates file if it does not exist
    log="/var/log/daily_tasks.log";
    notes_path="${HOME}/Documents/notes/daily_tasks";
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
    cur_month_path="${notes_path}/${cur_month}-${cur_year}";
    cur_week_path="${cur_month_path}/${cur_week}";
    cur_date_path="${cur_week_path}/${cur_date}";
    lecho "$cur_month - week beginning $cur_week";
    if [ ! -d $cur_month_path ]; then
        lecho "Making ${cur_month_path}";
        mkdir -p $cur_month_path;
    fi;
    if [ ! -d $cur_week_path ]; then
        lecho "Making ${cur_week_path}";
        mkdir -p $cur_week_path;
    fi;
    if [ ! -f $cur_date_path ]; then
        lecho "Adding template for today.";
        cat "${notes_path}/.day_log_template" > $cur_date_path;
    fi
    lecho "Opening notes";
    LAST_FILE=$(find ${notes_path} -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -nr | cut -d" " -f5 | sed '2q;d')
    echo $LAST_FILE
    vim $cur_date_path -o "${LAST_FILE}";
};

function todo () {
    vim ${HOME}/Documents/notes/daily_tasks/TODO;
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

# Source all files ending in _local
for file in $(/usr/bin/ls -a ~/ | grep -v "/" | grep ".*_local"); do
  source "${HOME}/${file}"
done

# Extend PATH
PATH="$HOME/.local/bin:$PATH"
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

if [ -d "/usr/share/doc/fzf" ]; then
  source /usr/share/doc/fzf/examples/key-bindings.bash
fi

# RipGrep
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# YouView setup
if [[ -f "$HOME/.youviewrc" ]]; then
  source $HOME/.youviewrc
fi

# Kube setup
which kubectl > /dev/null && \
  source <(kubectl completion bash) && \
  alias k=kubectl && \
  complete -o default -F __start_kubectl k && \
  [ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
  [ -f ~/.kubectl_local ] && source ~/.kubectl_local

eval "$(starship init bash)"
