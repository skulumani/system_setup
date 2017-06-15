
" Options for vimtex
if has('unix')
    if has('mac')
        let g:vimtex_view_method = "skim"
        let g:vimtex_view_general_viewer
                \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options = '-r @line @pdf @tex'

        " This adds a callback hook that updates Skim after compilation
        let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
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
        let g:latex_view_general_viewer = "zathura"
        let g:vimtex_view_method = "zathura"
    endif
elseif has('win32')

endif
let g:tex_flavor = "latex"
let g:vimtex_quickfix_open_on_warning = 0
if has('nvim')
    let g:vimtex_compiler_progname = 'nvr'
endif

" vim-surround in LaTeX
" augroup latexSurround
"     autocmd!
"     autocmd FileType tex call s:latexSurround()
" augroup END
" 
" function! s:latexSurround()
"     let b:surround_{char2nr("e")}
"     \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
"     let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
" endfunction
" if !exists('g:deoplete#omni#input_patterns')
"     let g:deoplete#omni#input_patterns = {}
" endif
" let g:deoplete#omni#input_patterns.tex = '\\(?:'
"             \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
"             \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
"             \ . '|hyperref\s*\[[^]]*'
"             \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
"             \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
"             \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
"             \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
"             \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
"             \ . '|usepackage(\s*\[[^]]*\])?\s*\{[^}]*'
"             \ . '|documentclass(\s*\[[^]]*\])?\s*\{[^}]*'
"             \ . '|\w*'
"             \ .')'
