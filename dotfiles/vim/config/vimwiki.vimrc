let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1, 'auto_diary_index': 1, 'auto_toc': 1, 'auto_generate_tags': 1}]
let g:vimwiki_global_ext = 0
let g:vimwiki_conceallevel = 0
let g:vimwiki_url_maxsave = 15
let g:vimwiki_markdown_link_ext = 1


function! VimwikiFindIncompleteTasks()
  lvimgrep /- \[ \]/ %:p
  lopen
endfunction

function! VimwikiFindAllIncompleteTasks()
  VimwikiSearch /- \[ \]/
  lopen
endfunction

function! VimwikiLinkHandler(link)
    let link = a:link
    if link =~# '^smb:'
        try
            execute '!open ' link
            return 1
        catch
            echo "SMB Link broken"
        endtry
    endif
    return 0
endfunction
