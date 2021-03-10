#!/usr/bin/env python

from email.Parser import Parser
from sys import stdin, stdout
import re
import base64
import quopri

plaintext_re = re.compile(r"\[CAUTION: Non-UBC Email\]\n\s*\n", re.MULTILINE)
html_re = re.compile(r'<table.*?>\s*?<tbody.*?>\s*?<tr.*?>\s*?<td.*?><font.*?>\[<strong.*?>CAUTION:</strong> Non-UBC Email\]</font>\s*?</td>\s*?</tr>\s*?</tbody>\s*?</table>', re.MULTILINE)

def filter(part):
  new_body = re.sub(html_re,'',re.sub(plaintext_re,'',part.get_payload(decode=True)))
  if part.__getitem__("Content-Transfer-Encoding") == "base64":
    return base64.b64encode(new_body)
  elif part.__getitem__("Content-Transfer-Encoding") == "quoted-printable":
    return quopri.encodestring(new_body)
  else:
    return new_body

def part_loop(parts):
  for part in parts:
    if part.is_multipart():
      part_loop(part.get_payload())
    if (part.get_content_type() == 'text/plain') or (part.get_content_type() == 'text/html'):
      part.set_payload(filter(part))
  return

prefix = stdin.readline()
message = Parser().parse(stdin)

if not message.is_multipart():
  message.set_payload(filter(message))
else:
  part_loop(message.get_payload())

stdout.write(prefix)
stdout.write(message.as_string())
