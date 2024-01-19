#!/bin/bash

function cd () { builtin cd "$@" && ls; }

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
