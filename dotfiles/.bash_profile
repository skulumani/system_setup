
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -f $HOME/.bashrc ]; then
    source ~/.bashrc
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH=$HOME/anaconda3/bin:"$PATH"
fi
