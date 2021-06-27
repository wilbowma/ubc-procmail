import mailbox
import sys
from datetime import datetime, timedelta
import tempfile
import os
import argparse
import email.utils
import re

def parse_email_timestamp(raw_timestamp):
  return datetime.fromtimestamp(email.utils.mktime_tz(email.utils.parsedate_tz(raw_timestamp)))

parser = argparse.ArgumentParser(description='Get only the most recent files from an mbox, printing a new mbox file')
parser.add_argument('mboxs', metavar="f", type=str, nargs='+', help="an mbox file to search")
ns = parser.parse_args()

for mbox in ns.mboxs:
  messages = mailbox.mbox(mbox)
  for msg in messages:
    # If there is a date header, use it, otherwise, user the first line, which
    # always contains a timestamp....
    raw_timestamp = msg['Date']
    if not raw_timestamp:
      raw_timestamp = re.sub("^From \w+? ", "", str(msg).partition("\n")[0])
    try:
      if parse_email_timestamp(raw_timestamp) > datetime.now()-timedelta(hours=36):
        print(msg)
    # if parsing a timestamp fails, log it, but just ignore that message.
    # ignoring a few messages is fine, since we're just using this for training
    # the spam filter.
    except Exception:
      sys.stderr.write("Exception while parsing Timestamp: \n  " + raw_timestamp)
      pass
