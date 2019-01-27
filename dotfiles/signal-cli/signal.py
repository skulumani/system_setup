#!/usr/bin/python3
# Need to install pydbus - pip3 install --user pydbus

from pydbus import SystemBus
from gi.repository import GLib
import argparse

def send_message():
    pass

def receive_message(timestamp, source, groupID, message, attachments):
    print ("msgRcv called")
    print (message)
    return

bus = SystemBus()
loop = GLib.MainLoop()

signal = bus.get('org.asamk.Signal')

signal.onMessageReceived = msgRcv
loop.run()

signal.sendMessage(string, [], ['number with country code'])
# replace ___USER___ with the corresponding phone number

signal.sendGroupMessage(data, [], [___GROUP___])
# replace ___GROUP___ with byte-representation of 
# e.g. 0x01, 0x23,  0x45, 0x67,  0x89, 0xab,   0xcd, 0xef,   0x01, 0x23,   0x45, 0x67,   0x89, 0xab,   0xcd, 0xef
# obtain these bytes by:
# grep "groupId" ___SIGNAL_CONFIG_FILE___
# where ___SIGNAL_CONFIG_FILE___ is the signal configuration stored in .config/signal/data/
# echo ___BASE64_REPRESENTATION___ | base64 --decode | hexdump -x
# where ___BASE64_REPRESENTATION___ is the string stored in that line
# and splitting the two-byte words into single bytes

if __name__ == "__main__":
    pass
