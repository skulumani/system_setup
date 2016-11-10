## New computer setup

1. Download [TexLive]()https://www.tug.org/texlive/
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
  
## Linux

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
