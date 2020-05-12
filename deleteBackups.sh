#!/bin/bash

VAULTNAME='NameGoesHere'
ACCOUNTID=00000000001
DAYS='+4'

for archiveid in `find /ZimbraBackup/ -type f -iname '*.txt' -mtime $DAYS -exec cat {} \;`
do
    /usr/local/bin/aws glacier delete-archive --vault-name $VAULTNAME --account-id $ACCOUNTID --archive-id $archiveid
done

for foldername in `find /ZimbraBackup/ -type d -mtime $DAYS`
do
    /usr/bin/rm -rf $foldername
done
