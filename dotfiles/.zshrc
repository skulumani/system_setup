# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# ANITGEN PLUGINS
source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip

# antigen bundle zsh-users/zsh-completions
# antigen bundle zsh-users/zsh-autosuggestions
# antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

antigen apply
# bundle settings
# Autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=1
bindkey '^ ' autosuggest-accept

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set vim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Load my personal bash aliases
source $HOME/.bash_aliases
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    setxkbmap -option "caps:escape"
fi
# check for caps lock and swap automatically

# ensure Enter sets newline
stty icrnl

# source all the PATH information
if [ -f $HOME/.path ]; then
    source $HOME/.path
fi

# Set 256 colors for the terminal
# export TERM=tmux-256color
export TERM=xterm-256color
# export COLORTERM=gnome-terminal

# setup for powerline

# if [ -f $HOME/anaconda3/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh ]; then 
#     powerline-daemon -q
#     source $HOME/anaconda3/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
# fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -f $HOME/.fzf.zsh ]]; then
    source $HOME/.fzf_options
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# try and fix completions in zsh
# compaudit | xargs -I '%' chmod g-w '%'
# compaudit | xargs -I '%' chown $USER:$USER '%'
# rm ~/.zcompdump*
# exec zsh

############## SPACESHIP THEME CUSTOMIZATION##################################
SPACESHIP_GIT_PREFIX=""
SPACESHIP_DIR_PREFIX=""

# added by travis gem
[ -f /home/shankar/.travis/travis.sh ] && source /home/shankar/.travis/travis.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
