# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [[ -n "$BASH_VERSION" ]]; then
    # include .bashrc if it exists
    if [[ -f "$HOME/.bashrc" ]]; then
	source "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Add TeXLive to PATH
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    export PATH=/usr/local/texlive/2016/bin/x86_64-linux:$PATH
    export MANPATH=/usr/local/texlive/2016/texmf-dist/doc/man:$MANPATH
    export INFOPATH=/usr/local/texlive/2016/texmf-dist/doc/info:$INFOPATH
fi

if [[ -f $HOME/.rvm/bin ]]; then
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi

# Add GOPath
if [[ -d /usr/local/go ]]; then
    export PATH=$PATH:/usr/local/go/bin
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH=$HOME/anaconda3/bin:"$PATH"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
