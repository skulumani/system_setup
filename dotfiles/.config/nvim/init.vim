
if has("win32")
	source $HOME\.vim\config\plugins.vimrc
	" source $HOME\.vim\config\general.vimrc
	" source $HOME\.vim\config\keys.vimrc
else

    source $HOME/.vim/config/plugins.vimrc
    source $HOME/.vim/config/general.vimrc
    source $HOME/.vim/config/keys.vimrc

    source $HOME/.vim/config/autocommand.vimrc
    
    " Plugin options
    source $HOME/.vim/config/autocomplete.vimrc
    source $HOME/.vim/config/appearance.vimrc
    source $HOME/.vim/config/vimtex.vimrc
    source $HOME/.vim/config/nerdtree.vimrc
    source $HOME/.vim/config/indentline.vimrc
    source $HOME/.vim/config/fzf.vimrc
    source $HOME/.vim/config/codechecking.vimrc 
    source $HOME/.vim/config/surround.vimrc
    source $HOME/.vim/config/vimwiki.vimrc
endif

 
