#!/usr/bin/env python

import os
import imaplib

path = os.path.dirname(os.path.realpath(__file__))
mail_client = imaplib.IMAP4_SSL('imap.gmail.com', '993')

if not os.path.isfile(f"{path}/config.py"):
    print(f"⚠ No mail config found. Check out \"{path}/config.py\"")
    exit()
else:
    from config import *

mail_client.login(user, password)

def check_mails():
    mail_client.select()
    unread = mail_client.search(None, 'UnSeen')
    return len(unread[1][0].split())

unread = check_mails()

if unread > 0 or not quiet:
    if not hide_unreads:
        print(prefix, unread)
    else:
        print(prefix)
else:
    print('')