" Jacob Straszynski's .zshrc
"
" Note: sure where a setting is being configured? `verbose set modeline?` for
" example. `verbose map ,e' also works.
"
" Note: when committing this repo, sometimes the various git-managed submodules
" turn out to have local changes that cause persistent untracked content
" warnings in git (you keep seeing an uncomitted file that stubbornly refuses
" to commit)
"
" See:
" http://stackoverflow.com/questions/7993413/git-submodules-with-modified-and-untracked-content-why-and-how-to-remove-it
"
" Related:
" http://stackoverflow.com/questions/5127178/gitignore-files-added-inside-git-submodules
"
" Installing vimballs
" open it in vim and type :source %

" For powerline see: https://github.com/Lokaltog/vim-powerline
set encoding=utf-8
let g:Powerline_symbols = 'unicode'

" Makes the mapleader not so crappy.
let mapleader = ","

" Enable filetype specific configuration by placing files into
" .vim/ftplugin/{js,py,rb,etc}.vim
filetype on

" Note: for making terminal colors work in OSX:
" http://stackoverflow.com/questions/3761770/iterm-vim-colorscheme-not-working


" INDENTATION and syntax
set ai
set ts=2
set sts=2
set sw=2
set mouse=a
set number
set hidden
set expandtab
" Allows selection of splits via mouse.
set ttymouse=xterm2

syntax reset
syntax on
colorscheme molokai
call pathogen#infect()
filetype plugin indent on
" Using cake dev command from express-coffescript project instead.
" au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
" I have an aliases file with some login aliases.
au BufNewFile,BufRead .*aliases set filetype=sh

"http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list,full
set wildmenu

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %
set backspace=indent,eol,start

" CtrlP Settings
" Instructions on ctrlp site, not sure what it's for:
" http://kien.github.com/ctrlp.vim/
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Clear highlights from incsearch. using ,<space>
nnoremap <leader><space> :noh<cr>
" Ignore hidden directories because they usually slow things down.
" Unless I'm in dotfiles
" Was using this formerly:
let g:ctrlp_custom_ignore = '\v[\/](Documents|Desktop|Downloads|Dropbox|Library|
\Music|Google\ Drive|Dropbox|Pictures|\.git|\.hg|\.svn|.Trash|tmp|venv|projectenv|static)'
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_depth = 5
nnoremap <leader>F :CtrlP<CR>
nnoremap <leader>f :CtrlPCurWD<CR>


" Add line without insert above/below
nnoremap <leader>O :<C-U>call append(line(".") -1, repeat([''], v:count1))<CR>
nnoremap <leader>o :<C-U>call append(line("."), repeat([''], v:count1))<CR>

" Toggle NERDTree with ,t
nmap <silent> <leader>t :NERDTreeToggle<CR>
nmap <silent> <leader>r :NERDTreeFind<CR>

" Get rid of stuff that makes VIM vi compatible that is apparrently crappy?
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim/#using-the-leader
set nocompatible
" Security fix - remove modeline support.
set modelines=1

" Various display options.
set ruler
set showmode
set showcmd
set visualbell
set cursorline
set ttyfast
set laststatus=2
" Relative numbering instead of line numbering, use the ruler instead for
" absolute.
silent! set relativenumber
" Creates an undofile that lets you conduct undoes after close and reopen.
silent! set undofile
" I don't like these.
silent! set noswapfile
set directory=$HOME/.vimtmp
set undodir=$HOME/.vimtmp

" Makes searching better
set ignorecase
" Overrides ignorecase if uppercase characters are used in a search.
set smartcase
" Global substitution on by default. g now reverts to single sub.
set gdefault
" Starts to highlight partial search results.
set incsearch
" Briefy jump to matching closing brackets.
" set showmatch super annoying
set nohlsearch
" Use perl style regex instead of vims goofiness
" These are annoying because they make me unable to refer to the search
" http://stackoverflow.com/questions/1497958/how-to-use-vim-registers
" register.
nnoremap / /\v
vnoremap / /\v


" Column wrapping
set wrap
set textwidth=79
" See :help fo-table
set formatoptions=qrn1
silent! set colorcolumn=85

" Automatically save current editor after tabbing away.
" au FocusLost * :wa
"
"
" Toggle syntax numbering
function! ToggleNumber()
    if(&relativenumber)
        set number
    else
        set relativenumber
    endif
endfunction
nmap <silent><leader>l :call ToggleNumber()<CR>

" Toggle paste mode
function! TogglePaste()
    if(&paste)
        set nopaste
    else
        set paste
    endif
endfunction
nmap <silent><leader>p :call TogglePaste()<CR>

" Shift tab dedent
nnoremap <s-tab> <<

" Nice hack for exiting a mode
inoremap jj <Esc>

" Paste From Buffer
nnoremap <leader><leader>p "*p
nnoremap <leader><leader>P "*P

" Close the current buffer.
nmap <silent> <leader>q :bdelete<CR>

" Map omnicompletion to jk
" inoremap jk <c-x><c-o>

" Markdown heading generation
nnoremap <leader>H yyp :s/./#/<cr> :noh<cr>
" Subheading
nnoremap <leader>sH yyp :s/./-/<cr> :noh<cr>

" Execute line under cursor - useful when editing these damn things.
" nnoremap <leader>e yy :<c-r>"<cr>k
" This is better, just source the file.
nnoremap <leader>e :so %<cr>

" Bufsurf forward and back in history
nnoremap <leader>a :BufSurfBack<CR>
nnoremap <leader>s :BufSurfForward<CR>

" Change paste "_ sets buffer to blackhole buffer, <C-R> loads register contents.
" We assume the default register.
nmap <silent> cp "_ciw<C-R>"<Esc>

" Add php highlighting to Phakefiles
au BufNewFile,BufRead Phakefile set filetype=php
" ReGenerate Tags
map <Leader>rgt :!ctags --extra=+f --exclude=.git --exclude=log -R * <CR><CR>

" Disable numbering for easier copy and paste
" mnemonic: mouse disable
nnoremap <leader>md :set mouse=r<cr> :set nonumber<cr> :set norelativenumber<cr> 
" mnemonic: mouse visual
nnoremap <leader>mv :set mouse=a<cr> :set relativenumber<cr>

" mouse all
nnoremap <leader>ma :set mouse=a<cr>
" mouse none
nnoremap <leader>mn :set mouse=r<cr>

" Rainbow paren
nnoremap <leader>R :RainbowParenthesesToggle<cr>

" Change variable to object notation for php
nnoremap <leader>vo mZ viW :s/\v\$(.*)\[\'(.*)\'\]/$\1->\2/ <cr><esc>`Z:noh<cr>
" Change variable to array notation for php
nnoremap <leader>va mZ viW :s/\v\$([^\ \=]*)-\>([^\ \=]*)/$\1['\2']/ <cr><esc>`Z:noh<cr>
" ca is used in nerdcommenter for changing comment types.
let g:xml_syntax_folding=1
au FileType glade setlocal foldmethod=syntax

au BufRead,BufNewFile *.aliases set filetype=zsh

" Show what you've changed in this buffer.
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" bufferdiff
nnoremap <leader>bd :DiffSaved<cr>
" close the diff buffer, the last <C-O> closes the other windows. 
nnoremap <leader>bo :diffoff<cr><C-W><C-O>

" edit the .vimrc file rapidly
nnoremap <leader>vr :e ~/.vimrc<cr>

set clipboard=unnamed

" Create a scrolling boundary of 5 lines from the top of the screen.
set so=5

" Don't add eol.
set noeol

" Open tagbar.
nnoremap <leader>T :TagbarToggle<CR>

" Highlight trailing whitespace
let c_space_errors=1
highlight ExtraWhitespace ctermbg=red guibg=red
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\s\+$/

" Search Dash for word under cursor
function! SearchDash()
  let s:browser = "/usr/bin/open"
  let s:wordUnderCursor = expand("<cword>")
  let s:url = "dash://".s:wordUnderCursor
  let s:cmd ="silent ! " . s:browser . " " . s:url
  execute s:cmd
  redraw!
endfunction
map <leader>d :call SearchDash()<CR>

" Clipboard

vmap <leader>m :w !pbcopy<CR><CR>
vmap <leader>M :!pbaste<CR>
nnoremap <leader>m :w !pbcopy<CR><CR>

" Replace trailing whitespace empty lines
nnoremap <leader>re /\v^([ ]{1,})([^ \t]{1,})@!$<cr>d$

let @q = '/MEDIA_URLda}da}i{% sttai€kb€kb€kbatic "f"i" %}'
