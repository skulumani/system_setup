
source $HOME/.vim/config/general.vimrc
source $HOME/.vim/config/keys.vimrc

source $HOME/.config/nvim/config/plugins.vim
 
" Plugin options

source $HOME/.vim/config/solarized.vimrc
source $HOME/.vim/config/airline.vimrc
source $HOME/.vim/config/vimtex.vimrc
source $HOME/.vim/config/nerdtree.vimrc
source $HOME/.vim/config/indentline.vimrc
source $HOME/.vim/config/utltisnips.vimrc
source $HOME/.vim/config/ctrlp.vimrc
 
" Deoplete settings
let g:deoplete#enable_at_startup = 1
command! DeopleteToggle call deoplete#toggle()
autocmd CompleteDone * pclose!
let g:deoplete#sources#jedi#show_docstring=1
" Neomake
" autocmd! BufWritePost * Neomake
 
