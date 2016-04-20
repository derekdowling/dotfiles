" Derek Dowling's .nvimrc
"
" Note: sure where a setting is being configured? `verbose set modeline?` for
" example. `verbose map ,e' also works.
"
" Note: you can also view color scheme mappiings with `:highlight`
"
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
Plug 'mileszs/ack.vim'
Plug 'othree/html5.vim'
Plug 'moll/vim-node'
Plug 'klen/python-mode'
Plug 'tomtom/tlib_vim'
Plug 'pangloss/vim-javascript'
Plug 'editorconfig/editorconfig-vim'
Plug 'rodjek/vim-puppet'
Plug 'Raimondi/delimitMate'
Plug 'garbas/vim-snipmate'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'SirVer/ultisnips'
Plug 'cespare/vim-toml'
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'mustache/vim-mustache-handlebars'
Plug 'fatih/vim-hclfmt'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'benekastah/neomake'

call plug#end()


" Makes the mapleader not so crappy.
let mapleader = ","

" Enable filetype specific configuration by placing files into
" .nvim/ftplugin/{js,py,rb,etc}.vim
filetype plugin indent on

" For Deoplete TAB Completion
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" LINTING
" Run Neomake Linters on Save
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']

let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1
" Support virtualenv
let g:pymode_virtualenv = 1
" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>pb'
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_folding = 0

" turns on syntastic for php and style checkers
let g:syntastic_go_checkers = ['go', 'golint', 'gotype', 'govet']
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_mode_map = { 'passive_filetypes': ['sass', 'scss'] }
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

autocmd BufRead,BufNewFile *.es6 setfiletype javascript

"http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list,full
set wildmenu

" Clear highlights from incsearch. using ,<space>
nnoremap <leader><space> :noh<cr>

" Add line without toggling insert mode above/below current line
nnoremap <leader>O :<C-U>call append(line(".") -1, repeat([''], v:count1))<CR>
nnoremap <leader>o :<C-U>call append(line("."), repeat([''], v:count1))<CR>

" File Fuzzy Finder Alias
nnoremap <C-p> :FZF<ENTER>

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

" Toggle syntax numbering
function! ToggleNumber()
    if(&relativenumber)
        set number
    else
        set relativenumber
    endif
endfunction
nmap <silent><leader>l :call ToggleNumber()<CR>

" Shift tab dedent
nnoremap <s-tab> <<

" Turns on Tabgar
nmap <F8> :TagbarToggle<CR>

" Nice hack for exiting a mode
inoremap jj <Esc>

" Change paste "_ sets buffer to blackhole buffer, <C-R> loads register contents.
" We assume the default register.
nmap <silent> cp "_ciw<C-R>"<Esc>

au BufNewFile,BufRead *.tmpl set filetype=html

" Disable numbering for easier copy and paste
" mnemonic: mouse disable
" nnoremap <leader>md :set mouse=r<cr> :set nonumber<cr> :set norelativenumber<cr>
" mnemonic: mouse visual
"nnoremap <leader>mv :set mouse=v<cr> :set relativenumber<cr>
" mouse all
nnoremap <leader>m :set mouse=a<cr>
" mouse none
nnoremap <leader>M :set mouse=r<cr>

" Rainbow paren
nnoremap <leader>R :RainbowParenthesesToggle<cr>

" ca is used in nerdcommenter for changing comment types.
let g:xml_syntax_folding=1
au FileType glade setlocal foldmethod=syntax

au BufRead,BufNewFile *.aliases set filetype=zsh

" Create a scrolling boundary of 4 lines from top of the screen
set so=4

" Don't add eol.
set noeol

" NERDTree Tabs Config
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" Snippets
let g:UltiSnipsExpandTrigger="<tab>"

" Focus File Tree if folder opened, file, if file opened
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_smart_startup_focus=1
let g:nerdtree_tabs_open_on_new_tab=1
let g:nerdtree_tabs_autoclose=1

" Indentation Helpers
set list
set listchars=tab:»-,trail:·,extends:>,precedes:<
:autocmd BufReadPost * :DetectIndent
:let g:detectindent_preferred_expandtab=1
:let g:detectindent_preferred_indent=4

" Go Things
let g:go_fmt_command = "goimports"

if has("mac") || has("macunix")
    set guifont=Monaco\ for\ Powerline:h24
endif

" Tab Helpers
nnoremap <Leader>t :tabe %<Enter>
