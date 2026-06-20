#!/usr/bin/env python3
"""Injects Super+Tab via /dev/uinput — kernel-level, triggers compositor keybinds."""
import struct, fcntl, time, os

EV_SYN     = 0
EV_KEY     = 1
SYN_REPORT = 0
KEY_TAB      = 15
KEY_LEFTMETA = 125
BUS_USB    = 0x03

UI_SET_EVBIT   = 0x40045564
UI_SET_KEYBIT  = 0x40045565
UI_DEV_CREATE  = 0x5501
UI_DEV_DESTROY = 0x5502
UI_DEV_SETUP   = 0x405c5503

def emit(fd, type_, code, value):
    t = time.time()
    sec, usec = int(t), int((t % 1) * 1_000_000)
    os.write(fd, struct.pack('QQHHi', sec, usec, type_, code, value))

fd = os.open('/dev/uinput', os.O_WRONLY | os.O_NONBLOCK)
fcntl.ioctl(fd, UI_SET_EVBIT, EV_KEY)
fcntl.ioctl(fd, UI_SET_KEYBIT, KEY_LEFTMETA)
fcntl.ioctl(fd, UI_SET_KEYBIT, KEY_TAB)

name = b'hypr-hotcorner' + b'\0' * (80 - 14)
setup = struct.pack('HHHH', BUS_USB, 0, 0, 1) + name + struct.pack('I', 0)
fcntl.ioctl(fd, UI_DEV_SETUP, setup)
fcntl.ioctl(fd, UI_DEV_CREATE)
time.sleep(0.15)

emit(fd, EV_KEY, KEY_LEFTMETA, 1)
emit(fd, EV_SYN, SYN_REPORT, 0)
emit(fd, EV_KEY, KEY_TAB, 1)
emit(fd, EV_SYN, SYN_REPORT, 0)
time.sleep(0.05)
emit(fd, EV_KEY, KEY_TAB, 0)
emit(fd, EV_SYN, SYN_REPORT, 0)
emit(fd, EV_KEY, KEY_LEFTMETA, 0)
emit(fd, EV_SYN, SYN_REPORT, 0)

time.sleep(0.1)
fcntl.ioctl(fd, UI_DEV_DESTROY)
os.close(fd)
