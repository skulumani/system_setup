
" Options for vimtex
if has('unix')
    if has('mac')
        " let g:vimtex_view_method = "skim"
        " let g:vimtex_view_general_viewer
        "         \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        " let g:vimtex_view_general_options = '-r @line @pdf @tex'

        " This adds a callback hook that updates Skim after compilation
        " Deprecated
        " let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
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
let g:vimtex_quickfix_mode = 2
if has('nvim')
    let g:vimtex_compiler_progname = 'nvr'
endif

" if !exists('g:deoplete#omni#input_patterns')
"     let g:deoplete#omni#input_patterns = {}
" endif
" let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

" One of the neosnippet plugins will conceal symbols in LaTeX which is
" confusing
let g:tex_conceal = ""
let g:tex_fold_enabled = 1
let g:vimtex_fold_enabled = 0
let g:vimtex_fold_manual = 1
let g:vimtex_matchparen_enabled = 0
let g:fastfold_fold_command_suffixes = []

let g:matchup_override_vimtex = 1
let g:matchup_matchparen_deferred = 1
let g:vimtex_syntax_conceal_disable = 1 " don't conceal any symbols in vimtex

" Can hide specifc warning messages from the quickfix window
" Quickfix with Neovim is broken or something
" https://github.com/lervag/vimtex/issues/773
