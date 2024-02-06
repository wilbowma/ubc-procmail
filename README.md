# UBC CS Procmail filters

UBC CS has several versions of SpamAssassin installed, making it difficult to
configure the global site version to run machine that runs procmail.

I installed SpamAssassin locally on my home directory which should avoid these
problems.

To set up SpamAssassin with procmail, you must install the following
(particularly the cron job) on `kokanee.cs.ubc.ca`.
Most of the files can be edited from any of the remote machine, but currently
only `kokanee` has access to the INBOX folder, which is necessary for training
the classifier.

- Run `init-spamassassin.sh` on `kokanee.cs.ubc.ca` to get the environment
  variables setup to use my version of SpamAssassin.
  This installs environment variables in `.bashrc`.
- Add the contents of `crontab` to your crontab, on `kokanee.cs.ubc.ca`.
- Add the contents of `.procmailrc` to your `.procmailrc`, preferably near the
  top.
- Save messages to the `Junk` folder to train the spam filter, and autoblock
  that address; save messages to `CSFILTER` to only train the spam filter
  but not autoblock.
- Move messages out of `CSFILTER` to any other folder to get them retrained as
  ham. I typically move them back to my inbox.
- Optionally uncomment some supervision request patterns.
- Customize `~/.spamassassin/user_prefs` if you like.
  By default, you'll automatically get the customizations I've made in the
  `user_prefs` file found in this repo, which notably includes crowdsourced DNS
  allow and blocklists, and a reputation plugin which learns blocklists based on
  your spam filed in the `Junk` folder.


## Debugging
- Note that after a change to some of the remote machines, you may need to move
  your crontab from one to another. Pay attention to emails from tech that
  affect kokanee or remote.
- After a system upgrade, I may need to run `cpan -r`, if the Perl binary or
  standard libraries have been upgraded. In that case, also run `chmod -R go+xR
  perl5` to fix permissions.
