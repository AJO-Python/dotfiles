alias daily='cd ~/Documents/notes/daily_tasks/';
alias notes='cd ~/Documents/notes/';
alias apr='cd ~/Documents/HR/APR/';
alias aquilon='~/dotfiles/tmux/aquilon_session.sh';
alias python='python3';
alias workon='source .venv/bin/activate';
alias workoff='deactivate';
alias wincode='cd ~/Documents/code/';
alias slm_notes='grep -r -i slm ~/Documents/notes/daily_tasks/';
alias ..='cd ../';
alias ...='cd ../../';
alias ....='cd ../../../';
alias gh_token='cat ~/tokens/gh_token';
alias nr_token='cat ~/tokens/nr_token';
alias gl_all_token='cat ~/tokens/gl_all_token';
alias gl_basic_token='cat ~/tokens/gl_basic_token';
alias teams_reset='rm -rf /mnt/c/Users/adg51575/AppData/Roaming/Microsoft/Teams/*'
alias docker-full-restart='docker compose down; docker compose rm -fv; docker compose up'
alias docker-full-restart-detatch='docker compose down; docker compose rm -fv; docker compose up -d'
alias docker-full-restart-build='docker compose down; docker compose rm -fv; docker compose up -d --build && docker-compose logs -f'
alias rails='cd ~/rails/raildataingestion-docs'
alias fuck='sudo $(history -p !!)'
alias common='cd ~/.steam/steam/steamapps/common/'
alias ksp-server='dotnet ~/ksp_mods/LMPServer/Server.dll'
alias ksp-cd="cd .steam/debian-installation/steamapps/common/Kerbal\ Space\ Program/"
alias gs='git status'
alias gcm='git commit -m'
alias gpa='git pull --all --rebase --autostash'
alias gd='git diff'
alias connect_minio='kubectl port-forward -n minio-nid-secure svc/nid-secure-minio 9009:9000 2>&1 > /dev/null &'
