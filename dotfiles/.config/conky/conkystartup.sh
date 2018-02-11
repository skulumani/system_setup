#!/bin/bash

sleep 10
hddtemp -d /dev/sda /dev/sdb /dev/sdc
conky -c ~/.config/conky/conky_stats.conf
