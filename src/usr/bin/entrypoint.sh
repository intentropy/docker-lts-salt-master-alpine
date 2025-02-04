#!/bin/ash
salt-minion -l $LOG_LEVEL &
salt-api -l $LOG_LEVEL &
salt-master -l info $LOG_LEVEL