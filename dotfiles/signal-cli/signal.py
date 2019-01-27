#!/usr/bin/python3
# Need to install pydbus - pip3 install --user pydbus

from pydbus import SystemBus
from gi.repository import GLib
import argparse
from datetime import datetime

def send_message(number, message):
    bus = SystemBus()
    signal = bus.get('org.asamk.Signal')
    signal.sendMessage(message, [], number)
    return 0

def msgRcv(timestamp, source, groupID, message, attachments):
    # groupID is empty if not a group
    # attachments will be a path to the attachment

    # convert unix time to something useful
    # ts = datetime.utcfromtimestamp(int(timestamp)).strftime('%Y-%m-%d %H:%M:%S')
    print("\n{} From:{}\n{}".format(timestamp, source, message))
    # parse the message to check for strings
    return 0

def receive_message_loop():
    bus = SystemBus()
    loop = GLib.MainLoop()
    signal = bus.get('org.asamk.Signal')
    signal.onMessageReceived = msgRcv
    loop.run()

# signal.sendGroupMessage(data, [], [___GROUP___])
# replace ___GROUP___ with byte-representation of 
# e.g. 0x01, 0x23,  0x45, 0x67,  0x89, 0xab,   0xcd, 0xef,   0x01, 0x23,   0x45, 0x67,   0x89, 0xab,   0xcd, 0xef
# obtain these bytes by:
# grep "groupId" ___SIGNAL_CONFIG_FILE___
# where ___SIGNAL_CONFIG_FILE___ is the signal configuration stored in .config/signal/data/
# echo ___BASE64_REPRESENTATION___ | base64 --decode | hexdump -x
# where ___BASE64_REPRESENTATION___ is the string stored in that line
# and splitting the two-byte words into single bytes

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Send/Receive Signal messages")
    group = parser.add_mutually_exclusive_group()
    group.add_argument('--send', nargs=2, help="Send a message to number")
    group.add_argument('--receive', action='store_true', help='Receive messages and print')
    args = parser.parse_args()

    if args.send:
        number = args.send[1:]
        message = args.send[0]
        send_message(number, message)

    elif args.receive:
        receive_message_loop()
