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
    * Ensure you download the `python-dbus` package to allow for syncing

## Jabref setup
* Install [JabRef](http://www.jabref.org/) by downloading the latest version and copying to `/opt/jabref`
    * [Github Link](https://github.com/JabRef/jabref/releases/latest)
* Setup an application shortcut by running `setup_jabref_shortcut.sh`
* Setup Google Drive and download `home/shankar/Drive/docs/technical_papers/bibdesk_papers`
    * Set the main file directory in Jabref Options > Preferences > Main File directory to wherever the Google drive PDFs are located
* Install `renameplugin` Go to Tools > Manage Plugins > Install Plugin
* Import jabref settings
