#!/bin/bash
nmcli device disconnect enp3s0
nmcli device disconnect veth0caa2f5
nmcli device disconnect veth1c647b4
nmcli device disconnect veth3f04628
nmcli device disconnect veth40658a5
nmcli device disconnect veth59a09ee
nmcli device disconnect veth62f7bb1
nmcli device disconnect veth75863c5
nmcli device disconnect vethc457d36
nmcli device disconnect vethff8e51f
notify-send 'Wired disabled'
