#!/bin/sh

find ~/Mail/ -type f -not -iname "CSFILTER" -not -iname "Junk" -not -iname "Trash" -exec ~wilbowma/perl5/bin/sa-learn --mbox --ham /var/spool/mail/`whoami` {} +
~wilbowma/perl5/bin/sa-learn --mbox --spam ~/Mail/CSFILTER Mail/Junk; ~wilbowma/perl5/bin/spamassassin -r --mbox --add-to-blacklist ~/Mail/Junk
