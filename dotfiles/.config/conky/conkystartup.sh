#!/bin/bash

sleep 5
hddtemp -d /dev/sda /dev/sdb /dev/sdc /dev/sdd
conky -c ~/.config/conky/conky_stats.conf
