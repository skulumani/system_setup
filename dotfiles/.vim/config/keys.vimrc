" KEYBOARD MAPPINGS
" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" now we can scroll through a big wrapped line more easily
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Use ctags
command! MakeTags !ctags -R .

" Nerdtree hotkey to C-n
map <C-n> :NERDTreeToggle<CR>

nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>

" nnoremap <leader>s :set spell!<CR>
set spelllang=en_us

nmap <leader>l :set list!<CR> <bar> :IndentLinesToggle<CR> <bar> :LeadingSpaceToggle<CR>

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
if has("autocmd")
    autocmd BufReadPost fugitive://* set bufhidden=delete
    autocmd User fugitive 
                \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
                \   nnoremap <buffer> .. :edit %:h<CR> |
                \ endif
endif

nmap <leader>gst :Gstatus<cr>gg<C-n>
nnoremap <leader>gco :Gco 
nnoremap <leader>gp :Gpush <CR>
nnoremap <leader>gl :Gpull <CR>
nnoremap <leader>gd :Gdiff :0<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>glg :Git lg<CR>
nnoremap <leader>glg2 :Git lg2<CR>
nnoremap <leader>ge :Gedit <CR>
nnoremap <leader>gb :Gbrowse <CR>

xnoremap dp :diffput<CR>
xnoremap do :diffget<CR>

xnoremap <leader>du :diffupdate<CR>

" Todo.txt mappings
nnoremap <leader>td :e ~/.todo/todo.txt<CR>

" Search for todo or bug or fixme using AG
nnoremap <leader>fix :Ack \(FIXME\)\\|\(TODO\)\\|\(BUG\)<CR>
