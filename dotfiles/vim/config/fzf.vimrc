if executable('fzf')
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

if executable('rg')
    " let g:ackprg = 'ag --vimgrep'
    let g:ackprg = 'rg --vimgrep --no-heading'
    " FZF now included Rg support
    " command! -bang -nargs=* Rg
    "             \ call fzf#vim#grep(
    "             \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
    "             \   <bang>0 ? fzf#vim#with_preview('up:60%')
    "             \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    "             \   <bang>0)
    " command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
endif
