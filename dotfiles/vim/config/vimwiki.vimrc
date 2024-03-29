let apl_wiki = {}
let apl_wiki.path = '~/Documents/apl_notes/'
let apl_wiki.syntax = 'markdown'
let apl_wiki.ext = '.md'
let apl_wiki.auto_tags = 1
let apl_wiki.auto_diary_index = 1
let apl_wiki.auto_toc = 1
let apl_wiki.auto_generate_tags = 1

let main_wiki = {}
let main_wiki.path = '~/Documents/notes/'
let main_wiki.syntax = 'markdown'
let main_wiki.ext = '.md'
let main_wiki.auto_tags = 1
let main_wiki.auto_diary_index = 1
let main_wiki.auto_toc = 1
let main_wiki.auto_generate_tags = 1

let g:vimwiki_list = [apl_wiki, main_wiki]
" let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1, 'auto_diary_index': 1, 'auto_toc': 1, 'auto_generate_tags': 1}]


let g:vimwiki_global_ext = 0
let g:vimwiki_conceallevel = 1
let g:vimwiki_url_maxsave = 15
let g:vimwiki_markdown_link_ext = 1

" get path to vimwiki index :echo(vimwiki#var#get_wikilocal('path', 0) 
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

function! VimwikiFuzzySearch()
    VimwikiIndex
    let wikipath = vimwiki#vars#get_wikilocal('path')
    call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " .. shellescape(''), 1, fzf#vim#with_preview({'dir': wikipath}), 0)
endfunction
