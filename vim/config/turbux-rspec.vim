" Plugin: Turbux
" http://joshuadavey.com/post/15619414829/faster-tdd-feedback-with-tmux-tslime-vim-and
"
let g:no_turbux_mappings = 'no'

function! Run_all_specs()
  if filereadable("./zeus.json")
    return Send_to_Tmux("zeus rspec spec\n")
  elseif filereadable("./bin/rspec_all")
    return Send_to_Tmux("./bin/rspec_all\n")
  elseif filereadable("./bin/rspec")
    return Send_to_Tmux("bin/rspec spec\n")
  else
    return Send_to_Tmux("rspec spec\n")
  endif
endfunction

nmap <leader>r <Plug>SendTestToTmux
nmap <leader>R <Plug>SendFocusedTestToTmux
nmap <leader>g :call Run_all_specs()<cr>

" Promote Variable to RSpec Let
"
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

