#!/bin/bash

echo "*******************************************************"
echo "*     Zimbra - Backup all email accounts              *"
echo "*******************************************************"
echo""
#
echo Start time of the backup = $(date +%T)  
before="$(date +%s)"
#
echo ""
#
#
echo "Generating backup files ..."
sh /ZimbraBackup/scripts/zimbraBackupAllAccounts.sh
#
echo "Deleting old backup files on Glacier and removing logs ..."
sh /ZimbraBackup/scripts/deleteBackups.sh
#
echo The process lasted = $(date +%T)
# Calculating time
after="$(date +%s)"
elapsed="$(expr $after - $before)"
hours=$(($elapsed / 3600))
elapsed=$(($elapsed - $hours * 3600))
minutes=$(($elapsed / 60))
seconds=$(($elapsed - $minutes * 60))
echo The complete backup lasted : "$hours hours $minutes minutes $seconds seconds"
