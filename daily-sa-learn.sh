#!/bin/sh

# Learn ham by finding all the non-spam folders
HAM_FILE=`mktemp`
echo $HAM_FILE

find ~/Mail/ -type f -mtime 1 -not -iname "CSFILTER" -not -iname "Junk" -not -iname "Trash" -exec python ~wilbowma/procmail/get-recent.py /var/spool/mail/`whoami` {} + > $HAM_FILE

~wilbowma/perl5/bin/sa-learn --ham --mbox $HAM_FILE
rm -f $HAM_FILE

# Learn spam by finding the recent spam messages in the Manually Confirmed as Spam folder.
SPAM_FILE=`mktemp`

python ~wilbowma/procmail/get-recent.py ~/Mail/Junk > $SPAM_FILE

~wilbowma/perl5/bin/sa-learn --spam --mbox $SPAM_FILE

~wilbowma/perl5/bin/spamassassin -r --mbox --add-to-blacklist $SPAM_FILE

rm -f $SPAM_FILE
