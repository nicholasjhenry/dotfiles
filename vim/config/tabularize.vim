nmap <Leader>ae :Tabularize /=<CR>
vmap <Leader>ae :Tabularize /=<CR>
nmap <Leader>ar :Tabularize /=><CR>
vmap <Leader>ar :Tabularize /=><CR>
nmap <Leader>ac :Tabularize /:\zs<CR>
vmap <Leader>ac :Tabularize /:\zs<CR>

" Add automatic aligment
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
