" KEYBOARD MAPPINGS
" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" now we can scroll through a big wrapped line more easily
" nnoremap j gj
" nnoremap k gk

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
