#!/bin/bash
# modify /etc/pulse/default.pa
# > load-module module-stream-restore restore_device=false

i=0
while true;
do
    echo "Setting default sink to: $i";
    pacmd set-default-sink $i;
    pacmd list-sink-inputs | grep index | while read line
    do
        echo "Moving input: ";
        echo $line | cut -f2 -d' ';
        echo "to sink: $i";
        pacmd move-sink-input `echo $line | cut -f2 -d' '` $i;
    done;
    read -p "{CR} to continue, ^c to quit" 
    i=$(expr $i + 1);
done;

