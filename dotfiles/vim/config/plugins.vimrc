" Autoload vim plug if not already there
if has("win32")

else
if has("nvim")
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        " autocmd VimEnter * PlugInstall
    endif
else 
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        " autocmd VimEnter * PlugInstall
    endif
endif


" All the plugins are listed here
if has("win32")

else
if has('nvim')
    call plug#begin('~/.config/nvim/plug.vim')
else
    call plug#begin('~/.vim/plug.vim')
endif
endif
" Productivity
Plug 'junegunn/vim-plug'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-dispatch'
Plug 'freitass/todo.txt-vim'
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'andymass/vim-matchup'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-eunuch'
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'

" Appearance
Plug 'itchyny/lightline.vim'
Plug 'rafi/awesome-vim-colorschemes'
let g:polyglot_disabled = ['latex']
Plug 'sheerun/vim-polyglot'
Plug 'machakann/vim-highlightedyank' " highlight yanked text
Plug 'ryanoasis/vim-devicons'
" Plug 'chriskempson/base16-vim'

" Programming plugins
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
" Plug 'Yggdroot/indentLine'
Plug 'Konfekt/FastFold'

" Autocompletion stuff
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
" Plug 'zchee/deoplete-jedi'
" Plug 'Shougo/echodoc.vim'


" Code linting
if has("nvim")
    Plug 'neomake/neomake'
    Plug 'sbdchd/neoformat'
endif
" Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
" Plug 'Rip-Rip/clang_complete' " autcomplete for C++

" set rtp+=~/.fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
" Plug 'jremmen/vim-ripgrep'
" Plug 'dyng/ctrlsf.vim'

" snippet completion
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Tmux plugins
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'edkolev/tmuxline.vim' " makes tmux look like vim-airline


call plug#end()
" start all the plugins above
endif
