function! s:ExecuteInShell(command, bang)
  let _ = a:bang != '' ? s:_ : a:command == '' ? '' : join(map(split(a:command), 'expand(v:val)'))

  if (_ != '')
    let s:_ = _
    let bufnr = bufnr('%')
    let winnr = bufwinnr('^' . _ . '$')
    silent! execute  winnr < 0 ? 'new ' . fnameescape(_) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
    silent! :%d
    let message = 'Execute ' . _ . '...'
    call append(0, message)
    echo message
    silent! 2d | resize 1 | redraw
    silent! execute 'silent! %!'. _
    silent! execute 'resize ' . line('$')
    silent! execute 'autocmd BufUnload <buffer> execute bufwinnr(' . bufnr . ') . ''wincmd w'''
    silent! execute 'autocmd BufEnter <buffer> execute ''resize '' .  line(''$'')'
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>g :execute bufwinnr(' . bufnr . ') . ''wincmd w''<CR>'
  endif
endfunction

command! -complete=shellcmd -nargs=* -bang Shell call s:ExecuteInShell(<q-args>, '<bang>')
cabbrev shell Shell
