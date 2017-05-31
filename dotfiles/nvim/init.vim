if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
" setruntimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vim/vimrc
" 
"
"
filetype indent plugin on
" ctags command
command! MakeTags !ctags -R .

" Tab spacing
set autoindent
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround

set backspace=indent,eol,start
set hidden
set laststatus=2

set number
set relativenumber
set wrap

set colorcolumn=100

" Code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Finding files
set path+=**
set wildchar=<Tab> wildmenu wildmode=full

" Search highlighting
set incsearch 
set showmatch
set hlsearch

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Reformat text
vmap Q gq
nmap Q gqap

" Scroll through big lines easily
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" " Buffer tab completion
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

if has("autocmd")
    augroup vimrc 
        autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded " . $MYVIMRC | redraw
    augroup END
endif

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")

" Nerdtree hotkey to C-n
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" install plugins
call plug#begin('~/.config/nvim/plug.vim')
" Appearance
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Programming plugins
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Yggdroot/indentLine'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'neomake/neomake'

" Productivity
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'

call plug#end()

" Plugin options

" Solarized
set t_Co=256
syntax enable
set background=dark
colorscheme solarized

" Vim Airline
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1

" Vim-Conda
let g:conda_startup_msg_suppress=1

" Options for vimtex
if has('unix')
    if has('mac')
        let g:vimtex_view_method="skim"
        let g:vimtex_view_general_viewer
                \='/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options='-r @line @pdf @tex'

        " This adds a callback hook that updates Skim after compilation
        let g:vimtex_compiler_callback_hooks=['UpdateSkim']
        function! UpdateSkim(status)
            if !a:status | return | endif

            let l:out = b:vimtex.out()
            let l:tex = expand('%:p')
            let l:cmd = [g:vimtex_view_general_viewer, '-r']
            if !empty(system('pgrep Skim'))
            call extend(l:cmd, ['-g'])
            endif
            if has('nvim')
            call jobstart(l:cmd + [line('.'), l:out, l:tex])
            elseif has('job')
            call job_start(l:cmd + [line('.'), l:out, l:tex])
            else
            call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
            endif
        endfunction
    else
        let g:latex_view_general_viewer="zathura"
        let g:vimtex_view_method="zathura"
    endif
elseif has('win32')

endif
let g:tex_flavor="latex"
let g:vimtex_quickfix_open_on_warning=0
if has('nvim')
    let g:vimtex_compiler_progname='nvr'
endif
" Syntastic settings
let g:syntastic_mode_map = { 'mode': 'passive' } 
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 0
nnoremap <F7> :SyntasticCheck<CR> :lopen<CR>

" vim-surround in LaTeX
augroup latexSurround
    autocmd!
    autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
    let b:surround_{char2nr("e")}
    \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
    let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction

" Indent Lines coloring
let g:indentLine_setColors = 1

" UltiSnips Directory
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'

" Python path setting
let g:python_host_prog = '/home/shankar/anaconda3/envs/neovim2/bin/python'
let g:python3_host_prog = '/home/shankar/anaconda3/envs/neovim3/bin/python'
