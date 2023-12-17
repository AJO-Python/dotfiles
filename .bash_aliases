# generics
alias ....='cd ../../../';
alias ...='cd ../../';
alias ..='cd ../';
alias gh_token='cat ~/tokens/gh_token';
alias gs='git status'
alias gcm='git commit -m'
alias gpa='git pull --all --rebase --autostash'
alias gd='git diff'
alias ll='ls -alF'
alias la='ls -a'
alias l='ls -F'
alias myip='dig TXT +short o-o.myaddr.l.google.com @ns1.google.com';
alias pls='sudo $(history -p !!)'
alias workon='source .venv/bin/activate';
alias workoff='deactivate';

# notes
alias daily='cd ~/Documents/notes/daily_tasks/';
alias notes='cd ~/Documents/notes/';

# docker & kube
alias docker-full-restart='docker compose down; docker compose rm -fv; docker compose up'
alias docker-full-restart-build='docker compose down; docker compose rm -fv; docker compose up -d --build && docker-compose logs -f'
alias docker-full-restart-detatch='docker compose down; docker compose rm -fv; docker compose up -d'
alias connect_minio='kubectl port-forward -n minio-nid-secure svc/nid-secure-minio 9009:9000 2>&1 > /dev/null &'

# steam
alias common='cd ~/.steam/steam/steamapps/common/'
alias ksp-server='dotnet ~/ksp_mods/LMPServer/Server.dll'
alias ksp-cd="cd .steam/debian-installation/steamapps/common/Kerbal\ Space\ Program/"
alias miryoku="/home/josh/qmk_firmware/keyboards/lily58/keymaps/miryoku_plus"

# starship
alias ls='exa --icons -F -H --group-directories-first'
