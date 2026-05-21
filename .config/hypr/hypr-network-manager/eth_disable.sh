#!/bin/bash
nmcli device disconnect enp3s0
nmcli device disconnect veth03fc9b6
nmcli device disconnect veth1c687df
nmcli device disconnect veth228da30
nmcli device disconnect veth2fa27c7
nmcli device disconnect veth7198c85
nmcli device disconnect veth911e464
nmcli device disconnect veth9b15d4e
nmcli device disconnect vethaa5d74f
nmcli device disconnect vethdc8e99c
notify-send 'Wired disabled'
