if executable('fzf')
    " <C-p> or <C-t> to search files
    nnoremap <silent> <C-t> :Tags <cr>
    nnoremap <silent> <C-p> :Files <cr>
    nnoremap <silent> <C-M-p> :Rg <CR>
    " nnoremap <silent> <C-m> :Map <CR>

    " search commits
    nnoremap <silent> <C-c> :Commits <CR> 

    " Search for all keyboard mappings
    " nnoremap <silent> <C-m> :Maps <CR>
    
    " <M-p> for open buffers
    nnoremap <silent> <M-p> :Buffers<cr>

    " <M-S-p> for MRU
    nnoremap <silent> <M-S-p> :History<cr>
    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
                \ { 'fg':      ['fg', 'Normal'],
                \ 'bg':      ['bg', 'Normal'],
                \ 'hl':      ['fg', 'Comment'],
                \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                \ 'hl+':     ['fg', 'Statement'],
                \ 'info':    ['fg', 'PreProc'],
                \ 'prompt':  ['fg', 'Conditional'],
                \ 'pointer': ['fg', 'Exception'],
                \ 'marker':  ['fg', 'Keyword'],
                \ 'spinner': ['fg', 'Label'],
                \ 'header':  ['fg', 'Comment'] }
    " Use fuzzy completion relative filepaths across directory
    " imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

    " Better command history with q:
    " command! CmdHist call fzf#vim#command_history({'right': '40'})
    " nnoremap q: :CmdHist<CR>

    " Better search history
    " command! QHist call fzf#vim#search_history({'right': '40'})
    " nnoremap q/ :QHist<CR>

    " command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': --no-color'})
else
    " CtrlP fallback
    echom "No FZF installed. Try again"
end

" Search option for ack.vim
if has('unix')
    " check for mac vs. linux
    let s:uname = system("uname")

    " You have to set these up using pip install.
    " I have conda environments setup already
    "
    " $ conda env create -f neovim2
    " $ conda env create -f neovim3
    " ... 
    "
    if s:uname == "Darwin\n"

        if executable('rg')
            " let g:ackprg = 'ag --vimgrep'
            let g:ackprg = 'rg --vimgrep --no-heading'

            command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

        endif
    else " linux

        if executable('rg_linux')
            " let g:ackprg = 'ag --vimgrep'
            let g:ackprg = 'rg_linux --vimgrep --no-heading'

            command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg_linux --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

        endif
    endif

endif
