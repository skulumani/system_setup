" KEYBOARD MAPPINGS
" Leader key goes to space
let mapleader=' '
let maplocalleader=' '
" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <leader>h :nohlsearch<Bar>:echo<CR>
" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" now we can scroll through a big wrapped line more easily
nnoremap j gj
nnoremap k gk

" autocenter on matched strings
noremap n nzz
noremap N Nzz

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Use ctags
" command! MakeTags !ctags -R .

" Use Netrw instead for speed
map <C-n> :NERDTreeToggle<CR>
" map <C-n> :Vex<CR>

nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>

" nnoremap <leader>w :write<CR> :echo "Saved file!"<CR>
" FZF mappings
" <C-p> or <C-t> to search files
nnoremap <silent> <leader>ft :Tags <cr>
nnoremap <silent> <leader>ff :Files <cr>
nnoremap <silent> <leader>fa :Rg <CR>
" search commits
nnoremap <silent> <leader>fc :Commits <CR> 
" Search for all keyboard mappings
nnoremap <silent> <leader>fm :Maps <CR>
" <M-p> for open buffers
nnoremap <silent> <leader>fb :Buffers<cr>
" <M-S-p> for MRU
nnoremap <silent> <leader>fh :History<cr>

" nnoremap <leader>s :set spell!<CR>
set spelllang=en_us

" tagbar
" nmap <leader>lg :set list!<CR> <bar> :IndentLinesToggle<CR> <bar> :LeadingSpaceToggle<CR>

" delete a buffer without closing split
" command Bd bp\|bd \#
nnoremap <leader>bd :bp<CR>:bd #<CR> 
" Delete all trailing whitespace with F5
" nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Vim-Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Fugitive stuff
" if has("autocmd")
"     autocmd BufReadPost fugitive://* set bufhidden=delete
"     autocmd User fugitive 
"                 \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
"                 \   nnoremap <buffer> .. :edit %:h<CR> |
"                 \ endif
" endif

nnoremap <leader>gst :Git<CR>
nnoremap <leader>gc :G commit -v -q<CR>
nnoremap <leader>gf :G commit -v -q %:p<CR>i
" nnoremap <leader>gt :Git tag -s<Space>
nnoremap <leader>gco :Git checkout<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gd :Gdiff :0<CR>
nnoremap <leader>ge :Gedit <CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>glg :Git lg<CR>
nnoremap <leader>glg2 :Git lg2<CR>
nnoremap <leader>gm :Git merge --no-ff<Space> 

xnoremap dp :diffput<CR>
xnoremap do :diffget<CR>

xnoremap <leader>du :diffupdate<CR>

" git gutter
" Jump between hunks
nmap <Leader>gnh <Plug>(GitGutterNextHunk)  " git next
nmap <Leader>gph <Plug>(GitGutterPrevHunk)  " git previous

" Hunk-add and hunk-revert for chunk staging
nmap <Leader>gah <Plug>(GitGutterStageHunk)  " git add (chunk)
nmap <Leader>guh <Plug>(GitGutterUndoHunk)   " git undo (chunk)

" Todo.txt mappings
" nnoremap <leader>td :e ~/.todo/todo.txt<CR>

" Search for todo or bug or fixme using AG
nnoremap <leader>fix :Ack \(FIXME\)\\|\(TODO\)\\|\(BUG\)<CR>

" Remap ESC for terminal window this will break the FZF windows
" tnoremap <Esc> <C-\><C-n>
"
" Neomake commands
if has('nvim')
    nnoremap <leader>m :Neomake<CR> :echo "LINTING!"<CR>
endif

augroup cpp_make
    autocmd!
    autocmd FileType cpp nnoremap <buffer> <leader>ll :make -C build -j4<CR><CR>
augroup END

" Options for vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vimwiki
nnoremap <leader>wf :call VimwikiFuzzySearch()<CR> 
nnoremap <F5> A<Space><C-r>=strftime("%Y-%m-%d")<CR><Esc>
