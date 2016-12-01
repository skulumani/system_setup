## New computer setup

* Graphics Drivers
    ~~~
    sudo add-apt-repository ppa:graphics-drivers/ppa
    ~~~
* [Google Chrome](https://www.google.com/chrome/)
* [SSH-Keys](https://help.github.com/enterprise/11.10.340/user/articles/generating-ssh-keys/) for Github/Bitbucket
    1. Check for keys
    ~~~
    ls -la ~/.ssh
    ~~~
    2. Generate new keys if empty - don't add a password
    ~~~
    ssh-keygen -t rsa -C "your_email@example.com"
    ~~~
    3. Add to `ssh-agent`
    ~~~
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    ~~~
    4. Copy SSH public key to Github/Bitbucket
    ~~~
    cat ~/.ssh/id_rsa.pub
    ~~~

* Install [BOINC](https://boinc.berkeley.edu/)
* Install [Gridcoin](http://gridcoin.us/)
* Matlab
* Anaconda3
    1. Modify LaTeXTools Python path
* [myrepos](https://myrepos.branchable.com)
    ~~~~
    sudo apt-get install myrepos
    git clone https://github.com/joeyh/myrepos.git
    cd myrepos
    cp ./mr /usr/local/bin/mr
    ~~~~

    `brew install mr`

    `sudo apt-get install myrepos`

* [Google Drive for Linux](https://github.com/odeke-em/drive)
    1. Install [go](https://github.com/golang/go/wiki/Ubuntu):
    ~~~
    sudo apt-get update
    sudo apt-get install golang
    ~~~
    2. Install [drive](https://github.com/odeke-em/drive/blob/master/platform_packages.md): 
    ~~~
    sudo add-apt-repository ppa:twodopeshaggy/drive
    sudo apt-get update
    sudo apt-get install drive
    ~~~
    3. `drive init` in a specific folder. 
    Make sure you're logged into `skulumani@gwmail.gwu.edu`
* [Redshift](http://jonls.dk/redshift/)
  * `sudo apt-get install redshift-gtk`
  * Add some configuration options to `/etc/geoclue/geoclue.conf`
    ```
    [redshift]
    allowed=true
    system=false
    users=
    ```
## Dot files

* Copy `gitconfig.md` to `~/.gitconfig`
* .profile
* .bashrc
* .mrconfig
* .driverc

Write a bash script to add automatic symbolic links

## [GPG setup](./gpg.md)

* Import GPG key from Lastpass into the system key store
~~~
gpg --import public.key
gpg --allow-secret-key-import --import private.key
~~~

## LaTeX Setup

Texlive
texmf tree
Sublime editor
Google Drive library
Jabref