# UBC CS Procmail filters

- run init-spamassassin.sh on remote.cs.ubc.ca to setup spamassassin
- add the contents of `crontab` to your crontab
- add the contents of `.procmailrc` to your `.procmailrc`, preferably near the
  top.
- save messages to the `Junk` folder to train the spam filter, and autoblock
  that address; save messages to `CSFILTER` to only use train the spam filter
  but not autoblock.
- move messages out of `CSFILTER` to any other folder to get them retrained as
  ham.
- Maybe uncomment some of the supervision request patterns
