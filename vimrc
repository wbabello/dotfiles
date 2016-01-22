" ###
" Much of this was stolen from awesome people who stole it. Many thanks
" to the giants whos shoulders I stand upon.
"   * Gary Bernhardt
"   * Ben Orenstein
"   * Jim Weirich
"   * Phil Cohen
" ###
" ========================================================================
" Vundle stuff
" ========================================================================
set nocompatible " Required by vundle
filetype off     " Required by vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My bundles
Plugin 'scrooloose/nerdtree'        " Project Drawer
Plugin 'ervandew/supertab'          " Tab completion
Plugin 'tpope/vim-bundler'          " Gemfiles
Plugin 'kien/ctrlp.vim'             " Fuzzy finder
Plugin 'godlygeek/tabular'          " Align text
Plugin 'vim-scripts/loremipsum'     " Lorem ipsum
Plugin 'vim-airline/vim-airline'    " easy mode

" Syntax
Plugin 'mattn/emmet-vim'            " html/css
Plugin 'kchmck/vim-coffee-script'   " Coffeescript
Plugin 'tpope/vim-rails'            " Rails
Plugin 'vim-ruby/vim-ruby'          " Ruby
Plugin 'plasticboy/vim-markdown'    " Markdown
Plugin 'eslint/eslint'              " E6
Plugin 'dsawardekar/ember.vim'      " Emberjs
Plugin 'mustache/vim-mustache-handlebars' " Handlebars
Plugin 'rust-lang/rust.vim'         " rustlang

" Colors
Plugin 'nanotech/jellybeans.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Use the colorscheme from above
colorscheme jellybeans

syntax on                 " Enable syntax highlighting

set shell=zsh
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set mouse=""
set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set autoindent
set showmatch
set nowrap
set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files
set autoread
set wmh=0
set viminfo+=!
set guioptions-=T
set guifont=Triskweline_10:h10
set et
set sw=2
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2  " Always show status line.
set relativenumber
set number
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on
set bg=light

" bernhardt love
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l


" Enable built-in matchit plugin
runtime macros/matchit.vim
" ================

let mapleader = ","

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>sp :set spell!<CR>

" Set region to British English
set spelllang=en_us

let g:user_emmet_leader_key='<tab>'

" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^

" simple load vimrc
nmap <silent> <leader>v :sp $MYVIMRC<CR>

" simple load nerdtree
nmap <silent> <leader>d :NERDTreeToggle<CR>

" simple load rails server
nmap <silent> <leader>rs :!rails s<CR>

" simple migrate
nmap <silent> <leader>rdb :!rake db:migrate<CR>

" simple open db/schema
nmap <silent> <leader>sc :sp db/schema.rb<CR>

" Set the tag file search order
set tags=./tags;

" Use _ as a word-separator
" set iskeyword-=_

" Make the omnicomplete text readable
:highlight PmenuSel ctermfg=black

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=yellow

" Format xml files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

augroup prewrites
  autocmd!
  " Remove trailing whitespace on save for ruby files.
  au BufWritePre *.rb :%s/\s\+$//e
  au BufReadPost *.hbs set syntax=html

augroup END 

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

set nofoldenable " Say no to code folding...

command! Q q " Bind :Q to :q
command! Qall qall
command! QA qall
command! E e


" Disable Ex mode
map Q <Nop>

" Disable K looking stuff up
map K <Nop>

au BufNewFile,BufRead *.txt setlocal nolist " Don't display whitespace

" Better? completion on command line
set wildmenu
" What to do when I press 'wildchar'. Worth tweaking to see what feels right.
set wildmode=list:full

" (Hopefully) removes the delay when hitting esc in insert mode
set noesckeys
set ttimeout
set ttimeoutlen=1

inoremap <Tab> <C-P>

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations.
set timeoutlen=500


" Set gutter background to black
highlight SignColumn ctermbg=black

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Make it more obvious which paren I'm on
hi MatchParen cterm=none ctermbg=black ctermfg=yellow

" ========================================================================
" End of things set by me.
" ========================================================================

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " By default, vim thinks .md is Modula-2.
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown

  " Wrap the quickfix window
  autocmd FileType qf setlocal wrap linebreak

  augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
  augroup END
  " Don't go past 100 chars on levelup:
  autocmd BufNewFile,BufRead /Users/ben/code/levelup/*.rb set colorcolumn=100


  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

  augroup END

  augroup rubystuff
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType rust,ruby,eruby,yaml setlocal ai sw=2 sts=2 et
    autocmd FileType rust,ruby,eruby,yaml setlocal path+=lib
    autocmd FileType rust,ruby,eruby,yaml setlocal colorcolumn=80
    " Make ?s part of words
    autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?

  augroup END

  augroup xmpfilter
    autocmd!
    autocmd FileType ruby nmap <buffer> <D-M> <Plug>(xmpfilter-mark)
    autocmd FileType ruby nmap <buffer> <D-R> <Plug>(xmpfilter-run)
  augroup END

  augroup markdown
    au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,README.md  setf markdown
    autocmd FileType markdown set wrap linebreak nolist
  augroup END

endif " has("autocmd")
