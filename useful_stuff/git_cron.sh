#!/bin/bash

function lecho () {
    now=`date +"[%Y-%m-%d %H:%M:%S]"`;
    echo "$now $1" >> /var/log/git_cron.log;
};

cd ~/dotfiles;
good_response="Already up-to-date.";
response=`git pull`;
if [ "$response" = "$good_response" ]; then
    lecho "pull successful";
    git add -A;
    git commit -m "daily updates";
    git push;
    lecho "changes pushed.";
else
    lecho "git pull failed to return $good_response";
fi;
