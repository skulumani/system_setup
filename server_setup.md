## Server setup

1. `rclone`
    Remote for borgbackup
    Remote for video camera footage
    Auto delete video camera footage
2. boinc
3. borgbackup
4. homeassistant
5. glances
    `sudo apt-get install lm-sensors hddtemp` 
6. Syncthing


## SSH Port forwarding

~~~
ssh -L 9384:127.0.0.1:8384 remote-server
~~~
