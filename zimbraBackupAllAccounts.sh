#!/bin/bash
#
# Make a list of user accounts and back them up to a zip file
#


ZHOME=/opt/zimbra
ZBACKUP=/ZimbraBackup
ZCONFD=$ZHOME/conf
DATE=`date +"%m%d%Y"`
ZDUMPDIR=$ZBACKUP/$DATE
ZMBOX=/opt/zimbra/bin/zmmailbox
VAULTNAME=YourVaultHere

if [ ! -d $ZDUMPDIR ]; then
       mkdir -p $ZDUMPDIR
fi

echo " Running zmprov ... "

for mbox in `zmprov -l gaa`
do
       filename="${mbox}_${DATE}"
       echo " Generating files from backup $mbox ..."
       $ZMBOX -z -m $mbox getRestURL "//?fmt=zip" > $ZDUMPDIR/$filename.zip
       echo " Uploading $mbox to AWS Glacier, deleting local copy, and writing archiveID to log ..."
       aws glacier upload-archive --account-id - --vault-name $VAULTNAME  --body $ZDUMPDIR/$filename.zip | grep "archiveId" | cut -f2 -d ":" > $ZDUMPDIR/$filename.txt
       rm $ZDUMPDIR/$filename.zip
done
