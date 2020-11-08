command! TagFiles :call EchoTags()
function! EchoTags()
  echo join(split(&tags, ','), "\n")
endfunction
