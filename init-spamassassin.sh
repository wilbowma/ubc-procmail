#!/bin/sh

mkdir -p ~/.spamassassin/{lib,gpg}
cp -r /etc/mail/spamassassin ~/.spamassassin/lib/
sa-update --gpghomedir ~/.spamassassin/gpg/ --updatedir ~/.spamassassin/lib/
cp user_prefs ~/.spamassassin/
cp -f init.pre ~/.spamassassin/lib/
