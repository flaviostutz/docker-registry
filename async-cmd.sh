#!/bin/bash

#THIS WILL WAIT FOR COMMANDS TO BE EXECUTED FROM PIPE /async-cmd
#BEFORE EXECUTING THE COMMAND IT WILL KILL ANY PREVIOUSLY EXECUTED COMMAND IF STILL RUNNING

echo "Starting async cmd..."
if [ ! -f /async-cmd ]; then 
    mkfifo /async-cmd
fi

echo "Waiting commands from /async-cmd..."

while true; do
    CMD=$(cat /async-cmd)

    if [ "$CMD" != "" ]; then
        # echo "Received command '$CMD'"
        LAST_PID=$(cat /last.pid)
        if ps -p $LAST_PID > /dev/null 2>&1; then
            echo "Killing previous pid $LAST_PID"
            kill -9 $LAST_PID
        fi
        echo "" > /async-cmd&

        echo "EXEC '$CMD'"
        $CMD&
        echo $! > /last.pid
        cat /last.pid
        echo "" > /async-cmd&
    fi
done
