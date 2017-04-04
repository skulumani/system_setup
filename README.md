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
    5. To use `rsub` for remote sublime
    ~~~
    ln -s $(pwd)/config ~/.ssh/config
    ~~~
    6. On remote computer 
    ~~~
    wget -O ~/bin/rsub https://raw.github.com/aurora/rmate/master/rmate
    chmod +x ~/bin/rsub
    rsub ~/my_project/my_file.html
    ~~~
    7. Add path to `~/bin` to path in `.bashrc`
    ~~~
    export PATH="/home/skulumani/bin:$PATH"
    ~~~
* Install [BOINC](https://boinc.berkeley.edu/)
* Install [Gridcoin](http://gridcoin.us/)
* Matlab
    * Login into the [mathworks](http://www.mathworks.com/index.html?s_tid=gn_logo) using GWU account
    * Download latest release
* [Anaconda3](https://www.continuum.io/downloads#linux)
    1. Modify LaTeXTools Python path
    2. You can turn on/off Anaconda by modifying the path in `.bashrc`
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
    1. Install [go](https://golang.org/doc/install):
    ~~~
    tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
    ~~~
    2. Add `go` to the PATH by adding the following to `.profile`
    ~~~
    export PATH=$PATH:/usr/local/go/bin
    ~~~
    2. Install [drive](https://github.com/odeke-em/drive/blob/master/platform_packages.md): 
    ~~~
    go get -u github.com/odeke-em/drive/cmd/drive
    go get github.com/odeke-em/drive/drive-gen && drive-gen
    ~~~
    4. In case of `panic: invalid page type:` errors follow this [link](https://github.com/odeke-em/drive/wiki/Boltdb-breaks-drive-with-(panic:-invalid-page-type:)-or-(panic:--above-high-water-mark))
    
    ~~~
    $ cd $GOPATH/src/github.com/boltdb/bolt && git reset --hard 852d3024fa8d89dcc9a715bab6f4dcd7d59577dd
    $ drive-gen
    ~~~
    3. `drive init` in a specific folder. 
    Make sure you're logged into `skulumani@gwmail.gwu.edu`
* [Redshift](http://jonls.dk/redshift/)
  * `sudo apt-get install redshift-gtk`
  * Add some configuration options to `/etc/geoclue/geoclue.conf`
    ~~~
    [redshift]
    allowed=true
    system=false
    users=
    ~~~
## Dot files

All the dotfiles live in the `dotfiles/` directory.
You can go into `dotfiles/` and modify the `install.conf.yml` file which defines the symbolic 
links that should be created. 
After defining the links desired, you can then run `./install`

### TMUX Plugins
The plugin manager `tpm` lives inside `.tmux/plugins/tpm`. 
This manager will automatically clone any other plugins into the appropriate location.

To add a plugin, add the following to the bottom of `.tmux.conf`
~~~
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com/user/plugin'
# set -g @plugin 'git@bitbucket.com/user/plugin'
~~~

From within `tmux` then just run `prefix + r` to reload the configuration file, followed by
`prefix + I` (`Ctrl-A then Shift I`)

To uninstall a plugin `prefix + alt + u`
To update plugins `prefix + U`

### Vim plugins

Discuss how to install and load more plugins
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

## Xfce setup

For the time use this `%a %b %e %Y %T`

## Jekyll for website development

* Install [RVM(https://rvm.io/)]
~~~
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
rvm install ruby-2.3.0-dev
~~~
* Install bundler
~~~
gem install bundler execjs therubyracer
~~~
* Clone repo and navigate to the directory
~~~
bundle install
bundle update
~~~
* Create website
~~~
bundle exec jekyll serve
~~~
