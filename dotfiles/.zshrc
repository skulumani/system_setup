# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip

antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme robbyrussell

antigen apply

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

export COLORTERM=gnome-terminal
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
export TERM=xterm-256color

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
