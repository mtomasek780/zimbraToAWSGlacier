# zimbraToAWSGlacier
Scripts made to backup a Zimbra Open Source Edition to AWS Glacier along with cleaning up Glacier

These scripts loosely based off of Richardson Lima's scripts on https://wiki.zimbra.com/wiki/Backing_up_and_restoring_Zimbra_(Open_Source_Version)

Since I did repurpose his code, here's a link to him
http://br.linkedin.com/in/richardsonlima

These scripts are pretty straight forward:

Preliminary, make sure you "su - zimbra" and run "aws configure" to setup credentials for your AWS Glacier account, otherwise, you can feed the information through your scripts. This requires the AWS cli installed on your server.

BackupAllMailboxes.sh - Tracks the backup process and provides progress while invoking the two scripts that do the actual work. I suggest running this as a crontab on the zimbra account at the very bottom of the list.

zimbraBackupAllAccounts.sh - This will make a directory, if one does not exist, to store your backup logs that you'll need for Glacier.  It will use the date to make the backup job and a unique backup file name.  It will list all mailboxes and allow you to export the mailbox, zip it up, upload the file to AWS Glacier, then delete the file locally.

deleteBackups.sh - Set the DAYS variable to how many days old you want to delete, so in my script, it will not delete backups younger than +4 days.  If you want a week of backups, go +8, as an example.  Don't forget to populate your vaultname and accountid.  You do not need to pull an inventory of the vault because you will be using the JobId from the AWS Glacier backup.  Finally, it will delete the logs and the old folder to cleanup the JobID numbers you don't need anymore.

Enjoy!
