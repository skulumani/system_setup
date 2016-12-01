## New computer setup

1. [Google Chrome](https://www.google.com/chrome/)
2. [SSH-Keys](https://help.github.com/enterprise/11.10.340/user/articles/generating-ssh-keys/) for Github/Bitbucket
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
1. Download [TexLive](https://www.tug.org/texlive/)
2. Setup [Texmf](https://github.com/skulumani/texmf) tree
3. Install [Sublime](https://www.sublimetext.com/)
    `git config --global core.editor 'subl -w'`
    1. Clone [Sublime-Settings](https://github.com/skulumani/sublime_settings)
4. Install [BOINC](https://boinc.berkeley.edu/)
5. Install [Gridcoin](http://gridcoin.us/)
6. Matlab
7. Anaconda3
    1. Modify LaTeXTools Python path
8. Chrome
    1. Remote Desktop setup
    * [Desktop Enviornment](https://support.google.com/chrome/answer/1649523?hl=en)
    * [Screen Size](https://productforums.google.com/forum/#!topic/chrome/8PMxG69VJ6o)
9. GPG signing keys
    1. Install [Keybase](https://keybase.io/)
    ~~~
    curl -O https://prerelease.keybase.io/keybase_amd64.deb
    sudo dpkg -i keybase_amd64.deb
    sudo apt-get install -f
    run_keybase
    ~~~
    2. Export Keybase GPG key-pair
        * `keybase pgp pull` - pull keys from keybase
        * `keybase pgp list` - list pgp keys
        * `keybase pgp export -q 01019ee8044 | gpg --import` - import keybase key into GPG
        *  `keybase pgp export -q 01019ee8044 --secret | gpg --allow-secret-key-import --import` - import private key into GPG
        * `gpg --list-secret-keys` - list keys on system
        * `git config --global user.signingkey 666A332D` - set git to use the default GPG key
        * `subl ~/.gnupg/gpg.conf'` - add `default-key 666A332D` to set key as the default
        * `git commit -S` or `git tag -s` - now sign commits/tags
    3. Add email to GPG key
        * `gpg --list-keys`
        * `gpg --edit-key 666A332D` - edit the key
        * `adduid` - Type name, email, and comment then type `O`
        * `save` - save the key
        * 
10. SSH keys for Github/Bitbucket
11. [myrepos](https://myrepos.branchable.com)
    ~~~~
    sudo apt-get install myrepos
    git clone https://github.com/joeyh/myrepos.git
    cd myrepos
    cp ./mr /usr/local/bin/mr
    ~~~~

    `brew install mr`

    `sudo apt-get install myrepos`

12. [Google Drive for Linux](https://github.com/odeke-em/drive)
    1. Install [go](https://github.com/golang/go/wiki/Ubuntu):
    ~~~
    sudo add-apt-repository ppa:ubuntu-lxc/lxd-stable
    sudo apt-get update
    sudo apt-get install golang
    ~~~
    1a. Set `$GOPATH` - location where `drive` will install
    ~~~
    subl .bashrc
    export GOPATH=$HOME/go
    export PATH=$GOPATH:$GOPATH/bin:$PATH 
    ~~~
    2. Install [drive](https://github.com/odeke-em/drive/blob/master/platform_packages.md): 
    ~~~
    sudo add-apt-repository ppa:twodopeshaggy/drive
    sudo apt-get update
    sudo apt-get install drive
    ~~~
13. [NoMachine](https://www.nomachine.com/)

1. Gnome Desktop Envioronment
2. [Redshift](http://jonls.dk/redshift/)
  * `sudo apt-get install redshift-gtk`
  * Add some configuration options to `/etc/geoclue/geoclue.conf`
    ```
    [redshift]
    allowed=true
    system=false
    users=
    ```
3. [Glances](https://pypi.python.org/pypi/Glances)
