" Example Vim configuration.
" Copy or symlink to ~/.vimrc or ~/_vimrc.

set nocompatible                      " Must come first because it changes other options.

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

syntax enable                         " Turn on syntax highlighting.
filetype plugin indent on             " Turn on file type detection.

runtime macros/matchit.vim            " Load the matchit plugin.

set showcmd                           " Display incomplete commands.
set showmode                          " Display the mode you're in.

set backspace=indent,eol,start        " Intuitive backspacing.

set hidden                            " Handle multiple buffers better.

set wildmenu                          " Enhanced command line completion.
set wildmode=list:longest             " Complete files like a shell.

set ignorecase                        " Case-insensitive searching.
set smartcase                         " But case-sensitive if expression contains a capital letter.

set number                            " Show line numbers.
set ruler                             " Show cursor position.

set incsearch                         " Highlight matches as you type.
set hlsearch                          " Highlight matches.

set wrap                              " Turn on line wrapping.
set scrolloff=3                       " Show 3 lines of context around the cursor.

set title                             " Set the terminal's title

set visualbell                        " No beeping.

set nobackup                          " Don't make a backup before overwriting a file.
set nowritebackup                     " And again.
set directory=$HOME/.vim-tmp//,.      " Keep swap files in one location

set tabstop=2                         " Global tab width.
set shiftwidth=2                      " And again, related.
set expandtab                         " Use spaces instead of tabs

set laststatus=2                      " Show the status line all the time

set list                              " Show invisble chars
set listchars=tab:▸\ ,eol:¬,trail:.   " Use the same symbols as TextMate for tabstops and EOLs

set grepprg=ack                       " Use Ack instead of grep

set pastetoggle=<F2>

set colorcolumn=80                    " Highlights the 80th column

" http://robots.thoughtbot.com/post/19398560514/how-to-copy-and-paste-with-tmux-on-mac-os-x
set clipboard=unnamed

" enable project-specific .vimrc
set exrc
set secure

" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" Or use vividchalk
let g:solarized_termcolors = 16
colorscheme solarized
set background=light

" Leader
let mapleader = ","

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Uncomment to use Jamis Buck's file opening plugin
map <Leader>ff :FuzzyFinderTextMate<Enter>

" Controversial...swap colon and semicolon for easier commands
"nnoremap ; :
"nnoremap : ;

"vnoremap ; :
"vnoremap : ;

" Automatic fold settings for specific files.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" Fold Settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=0

" Custom Mappings
nmap <leader>l :set list!<CR>            " Use the same symbols as TextMate for tabstops and EOLs
nmap <leader>rt :%s=\s\+$==<CR>          " Removes trailing spaces

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Save file with Sudo
cmap w!! w !sudo tee % >/dev/null

" Prevent <F24> <F25> showing up when I Command-Tab in command mode
"
cnoremap <f24> <nop>
cnoremap <f25> <nop>

" exit to normal mode with 'jj'
inoremap jj <ESC>

"
""" Scripts
"

" Execute in Shell
"
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

" Configure for Vim and IRB
" http://vimcasts.org/episodes/running-vim-within-irb/
"
if has("autocmd")
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif
if &t_Co > 2 || has("gui_running")
  " Enable syntax highlighting
  syntax on
endif

" Strip trailing whitespace
" http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
"
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Open files in directory of current file
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

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

"
""" Configure built-in components
"

" Netrw
"
let g:netrw_liststyle=3 " Use tree-mode as default view"
" let g:netrw_browse_split=4 " Open file in previous buffer"
" let g:netrw_winsize=20

"
""" Configure plugins
"

" CtrlP
"
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<leader>t'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'

" Vim Dash
"
:nmap <silent> <leader>d <Plug>DashSearch

" Git-gutter
"
" Turn highlighting
highlight clear SignColumn

" Tabularize
"
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

" Turbux
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

" Xmpfilter
"
nmap <buffer> <F7> <Plug>(xmpfilter-run)
xmap <buffer> <F7> <Plug>(xmpfilter-run)
imap <buffer> <F7> <Plug>(xmpfilter-run)

nmap <buffer> <F6> <Plug>(xmpfilter-mark)
xmap <buffer> <F6> <Plug>(xmpfilter-mark)
imap <buffer> <F6> <Plug>(xmpfilter-mark)

" Code Climate
"

nmap <Leader>aa :CodeClimateAnalyzeProject<CR>
nmap <Leader>ao :CodeClimateAnalyzeOpenFiles<CR>
nmap <Leader>af :CodeClimateAnalyzeCurrentFile<CR>

" Plugin: Gutentags
"
let g:gutentags_cache_dir = '~/.tags_cache'
