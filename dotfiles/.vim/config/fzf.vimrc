if executable('fzf')
    " <C-p> or <C-t> to search files
    nnoremap <silent> <C-t> :Files <cr>
    nnoremap <silent> <C-p> :Files <cr>

    " <M-p> for open buffers
    nnoremap <silent> <M-p> :Buffers<cr>

    " <M-S-p> for MRU
    nnoremap <silent> <M-S-p> :History<cr>

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
