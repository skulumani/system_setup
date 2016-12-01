## New computer setup

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
* Download [TexLive](https://www.tug.org/texlive/)
	1. Download http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
	2. Create texlive directories
	~~~
	cd /usr/local
	sudo mkdir texlive
	cd texlive
	mkdir 2016
	sudo chown -R shankar: /usr/local/texlive/
	sudo chmod -R u+rw /usr/local/texlive/
	~~~
	3. Extract and run `./install-tl`
	4. Set PATH - add to `~/.bashrc` and `~\.profile` modify for year
	~~~
	# Add TeXLive to PATH
    export PATH=/usr/local/texlive/2016/bin/x86_64-linux:$PATH
    export MANPATH=/usr/local/texlive/2016/texmf-dist/doc/man:$MANPATH
    export INFOPATH=/usr/local/texlive/2016/texmf-dist/doc/info:$INFOPATH
	~~~
    5. Set paper size `tlmgr paper letter`
    6. Update `tlmgr update --list` and `tlmgr update --all`
* Setup [Texmf](https://github.com/skulumani/texmf) tree in `~/texmf`
* Install [Sublime](https://www.sublimetext.com/)
    `git config --global core.editor 'subl -w'`
	* Start Sublime first before cloning settings
	* Install [Package Control](https://packagecontrol.io/installation)
	* Clone [Sublime-Settings](https://github.com/skulumani/sublime_settings) to `~/.config/sublime-text-3/Packages/User/setup_repo.sh`
* Install [BOINC](https://boinc.berkeley.edu/)
* Install [Gridcoin](http://gridcoin.us/)
* Matlab
* Anaconda3
    1. Modify LaTeXTools Python path
* GPG signing keys
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



