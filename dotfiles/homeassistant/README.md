## Documentation

* [Autostart](https://www.home-assistant.io/docs/autostart/systemd/)
* [Manual VirtualEnv Install](https://www.home-assistant.io/docs/installation/raspberry-pi/)

Switch to virtual environment

~~~
$ sudo -u homeassistant -H -s
$ source /srv/homeassistant/bin/activate
~~~

Start and monitor homeassistant

~~~
sudo systemctl restart home-assistant@homeassistant.service && sudo journalctl -f -u home-assistant@homeassistant
~~~

## Configuration files

* [Github repo](git@github.com:skulumani/homeassistant.git)
*
