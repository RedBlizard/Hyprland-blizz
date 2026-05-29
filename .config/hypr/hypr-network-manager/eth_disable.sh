#!/bin/bash
nmcli device disconnect enp3s0
nmcli device disconnect veth0235f0d
nmcli device disconnect veth85684fb
nmcli device disconnect vethadbc682
nmcli device disconnect vethbdc8eb5
nmcli device disconnect vethc4ee59a
nmcli device disconnect vethcb882af
nmcli device disconnect vethcba9b81
nmcli device disconnect vethd9b4b1d
nmcli device disconnect vethf0c6306
notify-send 'Wired disabled'
