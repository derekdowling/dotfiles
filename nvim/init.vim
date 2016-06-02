" Derek Dowling's .nvimrc
"
" Note: sure where a setting is being configured? `verbose set modeline?` for
" example. `verbose map ,e' also works.
"
" Note: you can also view color scheme mappiings with `:highlight`

" Make deoplete happy
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" Loads vim-plug :PlugInstall to install inside vim
call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fugitive'
Plug 'Lokaltog/vim-easymotion'
Plug 'ciaranm/detectindent'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'fatih/vim-go'
Plug 'othree/html5.vim'
Plug 'moll/vim-node'
Plug 'klen/python-mode'
Plug 'tomtom/tlib_vim'
Plug 'pangloss/vim-javascript'
Plug 'editorconfig/editorconfig-vim'
Plug 'rodjek/vim-puppet'
Plug 'Raimondi/delimitMate'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'cespare/vim-toml'
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'mustache/vim-mustache-handlebars'
Plug 'fatih/vim-hclfmt'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'carlitux/deoplete-ternjs'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'benekastah/neomake'
Plug 'rking/ag.vim'

call plug#end()

" Makes the mapleader not so crappy.
let mapleader = ","

" Enable filetype specific configuration by placing files into
" .nvim/ftplugin/{js,py,rb,etc}.vim
filetype plugin indent on

" Auto-Commands
autocmd BufRead,BufNewFile *.es6,*.test.js,*.spec.js setfiletype javascript
au BufNewFile,BufRead *.tmpl set filetype=html
au BufRead,BufNewFile *.aliases set filetype=zsh
:autocmd BufReadPost * :DetectIndent
autocmd! BufWritePost * Neomake

" Don't open first Ag value in buffer automatically
ca Ag Ag!

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" For Deoplete TAB Completion
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ["neosnippet"]

" See: https://github.com/Shougo/deoplete.nvim/issues/157
" I want to use my tab more smarter. If we are inside a completion menu jump
" to the next item. Otherwise check if there is any snippet to expand, if yes
" expand it. Also if inside a snippet and we need to jump tab jumps. If none
" of the above matches we just call our usual 'tab'.
function! s:neosnippet_complete()
  if pumvisible()
    return "\<c-n>"
  else
    if neosnippet#expandable_or_jumpable() 
      return "\<Plug>(neosnippet_expand_or_jump)"
    endif
    return "\<tab>"
  endif
endfunction

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

imap <expr><TAB> <SID>neosnippet_complete()

" LINT/MAKE Options
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck', 'deadcode', 'unconvert', 'gosimple']

let g:neomake_open_list = 2
let g:neomake_go_enabled_makers = []
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_scss_enabled_makers = ['scsslint']

let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_write = 1
let g:pymode_virtualenv = 1
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>pb'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_folding = 0

" turns on syntastic for php and style checkers
" let g:syntastic_go_checkers = ['gotype', 'errcheck']
" let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go', 'sass', 'scss', 'html'] }
let g:jsx_ext_required = 0
let g:syntastic_ruby_checkers = ['rubocop', 'rubylint']

" Note: for making terminal colors work in OSX:
" http://stackoverflow.com/questions/3761770/iterm-vim-colorscheme-not-working

set noswapfile

" Un-neuters backspace
set backspace=indent,eol,start

" INDENTATION and syntax 
set ai
set ts=4
set sts=4
set sw=4
"set mouse=a
set number
set hidden
set expandtab
syntax reset

" Turn Mouse God Mode On For Terminal Vim
set mouse=a


"http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list,full
set wildmenu

" Clear highlights from incsearch. using ,<space>
nnoremap <leader><space> :noh<cr>

" Add line without toggling insert mode above/below current line
nnoremap <leader>O :<C-U>call append(line(".") -1, repeat([''], v:count1))<CR>
nnoremap <leader>o :<C-U>call append(line("."), repeat([''], v:count1))<CR>

" Shortcut for opening loclist
nnoremap <leader>l :lopen<ENTER>

" File Fuzzy Finder Alias plus fix to not open selection in NerdTree:
" https://github.com/junegunn/fzf/issues/453
nnoremap <silent> <expr> <C-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"

" Some custom movement bindings I like
nnoremap H 0
nnoremap J 15j
nnoremap K 15k
nnoremap L $

" Split Management
nnoremap <C-h> <C-W><C-H>
set splitbelow
set splitright

" NERDCommenter Settings
let NERDSpaceDelims=2 " place spaces after comment chars
let NERDTreeIgnore = ['\.pyc$']

" Get rid of stuff that makes VIM vi compatible that is apparrently crappy?
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim/#using-the-leader
set nocompatible
" Security fix - remove modeline support.
set modelines=0

" Various display options.
set ruler
set showmode
set showcmd
set visualbell
set cursorline
set ttyfast
set laststatus=2

" Color Scheme
syntax on
set t_Co=256
colorscheme molokai

" git commit formatting
autocmd Filetype gitcommit spell textwidth=72

" Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'badwolf'

" Relative numbering instead of line numbering, use the ruler instead for
" absolute.
silent! set relativenumber

" Makes searching better
set ignorecase

" Global substitution on by default. g now reverts to single sub.
set gdefault

" Starts to highlight partial search results.
set incsearch

" Briefy jump to matching closing brackets.
" set showmatch super annoying
set nohlsearch

" Column wrapping
set wrap
set textwidth=79
" See :help fo-table
set formatoptions=qrn1

" Make the 80 char width column helper a sane color
silent! set colorcolumn=85
hi ColorColumn ctermbg=236

" Shift tab dedent
nnoremap <s-tab> <<

" Nice hack for exiting a mode
inoremap jj <Esc>

" Change paste "_ sets buffer to blackhole buffer, <C-R> loads register contents.
" We assume the default register.
nmap <silent> cp "_ciw<C-R>"<Esc>


" Disable numbering for easier copy and paste
" mnemonic: mouse disable
" nnoremap <leader>md :set mouse=r<cr> :set nonumber<cr> :set norelativenumber<cr>
" mnemonic: mouse visual
"nnoremap <leader>mv :set mouse=v<cr> :set relativenumber<cr>
" mouse all
nnoremap <leader>m :set mouse=a<cr>
" mouse none
nnoremap <leader>M :set mouse=r<cr>

" ca is used in nerdcommenter for changing comment types.
let g:xml_syntax_folding=1
au FileType glade setlocal foldmethod=syntax


" Create a scrolling boundary of 4 lines from top of the screen
set so=4

" Don't add eol.
set noeol

" NERDTree Tabs Config
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" Focus File Tree if folder opened, file, if file opened
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_smart_startup_focus=1
let g:nerdtree_tabs_open_on_new_tab=1
let g:nerdtree_tabs_autoclose=1

" Indentation Helpers
set list
set listchars=tab:»-,trail:·,extends:>,precedes:<
:let g:detectindent_preferred_expandtab=1
:let g:detectindent_preferred_indent=4

if has("mac") || has("macunix")
    set guifont=Monaco\ for\ Powerline:h24
endif

" Tab Helpers
nnoremap <Leader>t :tabe %<Enter>
