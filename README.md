## New computer setup

* Mac specific setup
    * install all the source code pro fonts by double clicking on them and the powerline ones too
    * Install solarized terminal colorscheme. The Yosemite one works on 10.12 
    * Also you can change the default shell by going to Preferences > Users and Groups > Ctrl-Click username > Advanced Options and input the correct path to `zsh`
* Ubuntu steps
    * Change the terminal color scheme to solarized and make sure it's using Source Code Pro for the font
* Install [BOINC](https://boinc.berkeley.edu/)
* Install [Gridcoin](http://gridcoin.us/)
    * There's a repo that has the wallet backups and config files
* [Anaconda3](https://www.continuum.io/downloads#linux)
    2. You can turn on/off Anaconda by modifying the path in `.bashrc`
* [Google Drive for Linux](https://github.com/odeke-em/drive)
* [Redshift](http://jonls.dk/redshift/)
* [MyRepos](https://myrepos.branchable.com/)
    * There's a `mrconfig` file for the home directory.
* [OpenJDK]
    * On Ubuntu you can install `sudo apt-get install openjdk8-jre` to run JabRef
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
Just run `:PluginInstall` a few times and be happy

### `ctag` help

Run `:MakeTags` inside vim to generate all the tags for the current directory.
Then use one of the following:
* `Ctrl-]` to jump to tag under cursor
* `g-Ctrl-]` for ambiguous tag
* `Ctrl-t` to jump back up the tag stack
### Autocomplete for vim

Just type `Ctrl-n` for autocomplete then `Ctrl-n` or `Ctrl-p` to go forward and backward.

You can autocomplete filenames using `Ctrl-x` then `Ctrl-f`.

Look at `:help ins-completion` for extra help.


## `font` installation
* [Source Code Pro version](https://github.com/adobe-fonts/source-code-pro/releases/tag/2.030R-ro%2F1.050R-it)

All the fonts are in the `~/.fonts` directory which is installed by `dotbot`

## [GPG setup](./gpg.md)

* Import GPG key from Lastpass into the system key store
~~~
gpg --import public.key
gpg --allow-secret-key-import --import private.key
~~~

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

## Building Vim

Some useful links 

* [YouCompleteMe Instructions](https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source)
* [Github Gist](https://gist.github.com/Mistobaan/b1384a44e8b5a8b35c6e1c7a4c546e84)
* [Building Vim](https://www.xorpd.net/blog/vim_python3_install.html)

You should be able to simply run `./build_vim.sh`

Also depending on the options, you might need to install an Anaconda environment first.
