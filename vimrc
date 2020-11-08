" Example Vim configuration.
" Copy or symlink to ~/.vimrc or ~/_vimrc.

set nocompatible " Must come first because it changes other options.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

set colorcolumn=100                    " Highlights the nth column

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

" Open files in directory of current file
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure built-in components
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Netrw
"
let g:netrw_liststyle=3 " Use tree-mode as default view"
" let g:netrw_browse_split=4 " Open file in previous buffer"
" let g:netrw_winsize=20

source ~/.vim/config/ack.vim
source ~/.vim/config/code-climate.vim
source ~/.vim/config/ctags.vim
source ~/.vim/config/dash.vim
source ~/.vim/config/execute-in-shell.vim
source ~/.vim/config/fugitive.vim
source ~/.vim/config/fzf.vim
source ~/.vim/config/git-gutter.vim
source ~/.vim/config/gutentags.vim
source ~/.vim/config/neo-make.vim
source ~/.vim/config/ruby.vim
source ~/.vim/config/sql-formatter.vim
source ~/.vim/config/strip-trailing-spaces.vim
source ~/.vim/config/tabularize.vim
source ~/.vim/config/tmux.vim
source ~/.vim/config/turbux-rspec.vim
source ~/.vim/config/xmpfilter.vim
