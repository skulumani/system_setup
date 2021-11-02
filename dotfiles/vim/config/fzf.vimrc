if executable('fzf')
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
    let g:grepprg = 'rg --vimgrep --no-heading'

    " FZF now included Rg support
    " command! -bang -nargs=* Rg
    "             \ call fzf#vim#grep(
    "             \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
    "             \   <bang>0 ? fzf#vim#with_preview('up:60%')
    "             \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    "             \   <bang>0)
    " command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

    " special command to search in project root of current buffer
" command! -bang -nargs=* PRg
"   \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)

" search from current working directory
" command! -bang -nargs=* PRg
"   \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)
endif


" FZF configuration
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
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }


function! RgDir(isFullScreen, args)
    let l:restArgs = [a:args]

    let l:restArgs = split(l:restArgs[0], '-pattern=', 1)
    let l:pattern = join(l:restArgs[1:], '')

    let l:restArgs = split(l:restArgs[0], '-path=', 1)
    " Since 8.0.1630 vim has a built-in trim() function
    let l:path = trim(l:restArgs[1])

    call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " .. shellescape(l:pattern), 1, fzf#vim#with_preview({'dir': l:path}), a:isFullScreen)
endfunction

" the path param should not have `-pattern=`
command! -bang -nargs=+ -complete=dir RgD call RgDir(<bang>0, <q-args>)
" nnoremap <leader>zd :RgD -path= . -pattern=
" :RgD -path= . -pattern=main
" ok. equivalent to `:Rg main\(`
" :RgD -path= . -pattern=main\(
" " ok. equivalent to `:Rg <whitespace>main\(<whitespace>`
" :RgD -path= . -pattern=<whitespace>main\(<whitespace>
" " ok. equivalent to `:Rg cmd -pattern=param`
" :RgD -path= . -pattern=cmd -pattern=param
" " ok
" :RgD -path= ./Program Files -pattern=cmd -pattern=param
"
"
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

