#!/bin/sh

sh ~wilbowma/procmail/daily-sa-learn.sh
umask 022 && ~/perl5/bin/sa-update && PERL_MM_OPT='' ~/perl5/bin/sa-compile
#&& find perl5/ -mtime 1 -type d -not -path "sa-update-keys" -exec chmod g+rx {} + && find perl5/ -type f -not -path "sa-update-keys" -exec chmod g+r {} +
