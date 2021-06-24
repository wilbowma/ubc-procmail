import mailbox
import sys
from datetime import datetime, timedelta
import tempfile
import os
import argparse

def parse_email_timestamp(raw_timestamp):
  # Cleanup the timestamp, which might begin with a Day and a comma, and might end with a timezone declaration.
  # First split the day off, but it might not exist, so grab the -1th element of the split (either the 1st or the 0th if there was no day).
  # Then split off the timezone, which begins with either a + or -. Those characters ought not appear anywhere else?
  return datetime.strptime(raw_timestamp.split(",")[-1].split("+")[0].split("-")[0].strip(), "%d %b %Y %H:%M:%S")

parser = argparse.ArgumentParser(description='Get only the most recent files from an mbox, printing a new mbox file')
parser.add_argument('mboxs', metavar="f", type=str, nargs='+', help="an mbox file to search")
ns = parser.parse_args()

for mbox in ns.mboxs:
  messages = mailbox.mbox(mbox)
  for msg in messages:
    # If the email is "recent"; use 36 hours to account for timezone issues.
    if parse_email_timestamp(msg['Date']) > datetime.now()-timedelta(hours=36):
      print(msg)
