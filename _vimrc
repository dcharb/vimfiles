set nocompatible     " Configure for VIM instead of VI
let mapleader = ","  "set <leader> to ','

set fdm=marker  " Set folding type as marker. This allows vimrc to use comments for folding.

"  VUNDLE {{{
"------------------------------------------------------------------------------"
filetype off                  " required

" Set the runtime path to include vundle and initialize
if has('win32')
   set rtp+=$HOME/vimfiles/bundle/Vundle.vim
   call vundle#begin('$USERPROFILE/vimfiles/bundle/')
elseif has('unix')
   set rtp+=~/.vim/bundle/Vundle.vim
   call vundle#begin()
endif

" Vundle will manage vundle
Plugin 'VundleVim/Vundle.vim'

" All plugins defined between #begin and #end
Plugin 'camelcasemotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'd11wtq/ctrlp_bdelete.vim'
Plugin 'DoxygenToolkit.vim'
Plugin 'einars/js-beautify'
Plugin 'fatih/vim-go'
if has('win32')
   Plugin 'dcharb/findstr.vim'
elseif has('unix')
   Plugin 'grep.vim'
endif
Plugin 'fugitive.vim'
"Plugin 'gabrielelana/vim-markdown' -> This overrides the vimwiki <CR> normal mode command
Plugin 'idanarye/vim-merginal'
Plugin 'jshint.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'matchit.zip'
Plugin 'noahfrederick/vim-noctu'
Plugin 'pprovost/vim-ps1.git'
Plugin 'altercation/vim-colors-solarized'
Plugin 'sk1418/QFGrep'
"Plugin 'suan/vim-instant-markdown'
Plugin 'Tagbar'
Plugin 'The-NERD-Commenter'
Plugin 'tpope/vim-dispatch'
Plugin 'vimwiki/vimwiki'
Plugin 'Zenburn'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'
call vundle#end()

" }}}

" FILETYPE PLUGIN {{{
"------------------------------------------------------------------------------"
filetype on
filetype plugin on
filetype indent on

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1

let g:html_indent_inctags="head,body"
" }}}

" COLOURS and FONT {{{
"------------------------------------------------------------------------------"
if has( 'gui_running' )
   colors solarized                 " Set colour
else
   colors noctu
endif
syntax on                        " Turn on syntax highlighting
if has('win32')
   set guifont=Consolas:h10:cANSI   " Set the font
   au GUIEnter * simalt ~x          " Maximize window on startup
endif

" Highlight the current word everywhere
hi SameWord guifg=LightGray ctermfg=Brown
autocmd CursorMoved * exe printf('match SameWord /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" Make warning messages a little more visible
hi WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None

" }}}

"  WINDOW SETUP {{{
"------------------------------------------------------------------------------"
" Show the line numbers and column
set number
set ruler
set nowrap       " Wrap text on screen
set linebreak  " Wrap on characters in the breakat option. ie: space, tab, etc
set textwidth=100 " Wrap text at column 120
set colorcolumn=+1   " Show the max column as a different colour at textwidth+1

" Options for the GUI
set guioptions-=T  " Remove toolbar
set guioptions-=m  " Remove menu bar

" }}}

"  GENERAL SETTINGS {{{
"------------------------------------------------------------------------------"
" Set current working directory to always be the directory of the current file you're in
"set autochdir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>   " Change working directory to current file directory

" Hide unwanted buffers instead of requiring to close them when opening a new one
set hidden

inoremap jj <ESC>        " Press jj instead of ESC to exit insert mode

"set autoread         " Set to auto read when a file is changed from the outside
set ignorecase       " Ignore case when searching
set smartcase        " Don't ignore case if Uppercase letter included in search
set hlsearch         " Highlight search things
set incsearch        " Make search act like search in modern browsers
set nolazyredraw     " Don't redraw while executing macros
set magic            " Set magic on, for regular expressions
set showmatch        " Show matching brackets when text indicator is over them
set mat=2            " How many tenths of a second to blink
set nobackup         " Don't make a backup before overwriting a file
set nowb             " Don't make a backup before overwriting a file
set noswapfile       " Keep all files in memory
"set nowrapscan       " Don't wrap around when searching

" Indenting and tabbing
set autoindent       " Automatically indent
set smartindent      " Indent 'smartly'
set expandtab        " Insert spaces for tabs
set smarttab         " Insert tabs in front of a line according to shiftwidth
set cindent          " Use indentation options
set cinoptions=g0    " Set indent options. g0 - public/protected/private uses no indentation
set shiftwidth=3     " Number of spaces for autoindent
set tabstop=3        " How many spaces a tab is

" Allow backspace to go over autoindent, end of previous line, and before the
" start of where you started your insert
set backspace=indent,eol,start

set history=100     " Remember many commands and search history
set undolevels=100  " Number of undo levels

" Ignore some file extensions when opening files
set wildignore=*.swp,*.bak
set wildmenu
set wildmode=longest,list

" Sets the path variable which is used in the :find command
set path=.\**

" Allow make command to call ninja
if has('win32')
   set makeprg=ninja
endif

" }}}

"  FILETYPE SPECIFIC SETTINGS {{{
"------------------------------------------------------------------------------"

" MARKDOWN
au BufNewFile,BufRead *.md set filetype=markdown      " Set *.md file as markdown instead of module2 files
"au FileType markdown setlocal spell spelllang=en_ca   " Spell checking on for Canadian english
au FileType markdown setlocal shiftwidth=2
let g:markdown_fenced_languages = ['html', 'javascript' ]

" CODE
" Remove auto-commenting a new line in a *.c or *.cpp file
au FileType c,cpp setlocal comments-=:// comments+=f://

" JAVASCRIPT / JSON / YAML
au FileType javascript,json,yaml setlocal shiftwidth=2     " Number of spaces for autoindent
au FileType javascript,json,yaml setlocal tabstop=2        " How many spaces a tab is

" XML
" Automatically close tags when entering </ in xml files
au FileType xml,html inoremap </ </<C-x><C-o>

" Cucumber
au FileType cucumber setlocal shiftwidth=2     " Number of spaces for autoindent
au FileType cucumber setlocal tabstop=2        " How many spaces a tab is

" }}}

"  XML File Commands {{{
"------------------------------------------------------------------------------"
nnoremap <leader>xml :%s/></>\r</g<CR>:0<CR>=:$<CR>
vmap <leader>xml :'<,'>s/></>\r</g<CR>:0<CR>=:$<CR>
nnoremap <leader>val :cexpr system( "xmllint --noout --valid " . bufname("%") )<CR>:copen<CR>

" }}}

"  MOVING AROUND / SELECT ALL / EXTERNAL COPY & PASTE {{{
"------------------------------------------------------------------------------"
" Moving via sub words
nnoremap <silent> <b> :call search("[A-Z]\\\|\\\>", "b")<CR>
nnoremap <silent> <w> :call search("[A-Z]\\\|\\\>", "")<CR>

" Moving between windows easier
nnoremap <c-h> <C-W>h
nnoremap <c-l> <C-W>l
nnoremap <c-k> <C-W>k
nnoremap <c-j> <C-W>j

" Moving to parent tag in XML and end of block
nnoremap ]t vatatv
nnoremap [t vatatov

" Select all
nnoremap <leader>sa ggVG

" Copy & Paste using clipboard
vmap <leader>cop "+y
nnoremap <leader>pas "+gp

" Searching
if has('win32')
   nnoremap <c-f> :Rfindpattern /I<CR>
elseif has('unix')
   nnoremap <c-f> :Rgrep -i<CR>
endif

" Run external commands with R
"command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile "| read !<args>

" }}}

"  Custom mappings {{{

"  Remove READONLY file attribute from current file
"  w! - Saves file
"  !start - Start separate thread for command
"  cmd /c - Run command and exit when done
"  attrib -R % - Change current file (%) attributes to remove readonly (-R)
"------------------------------------------------------------------------------
if has('win32')
   nnoremap <leader>rro :w!<CR> :!start cmd /c attrib -R %<CR>
endif

"  Open HPP or CPP of same name
"------------------------------------------------------------------------------
nnoremap <leader>cpp :e %<.cpp<CR>
nnoremap <leader>hpp :e %<.hpp<CR>

" Insert current date and time
nmap <leader>tt i<C-R>=strftime("%H:%M:%S")<CR><Esc>
nmap <leader>td i<C-R>=strftime("%Y-%m-%d")<CR><Esc>

" }}}

"  Pandoc {{{
"------------------------------------------------------------------------------"
nnoremap <leader>pdf :!pandoc -f markdown -t latex -o %<.pdf --toc -V geometry:margin=1in %<CR>
nnoremap <leader>html :!pandoc -f markdown -t html5 -o %<.html --toc %<CR>
nnoremap <leader>word :!pandoc -f markdown -t docx -o %<.docx --toc %<CR>

" }}}

"  CTAGS {{{
"  Run the command below to create the tags file
"     cd C:\code
"     ctags -R -h hpp --extra=+q
"------------------------------------------------------------------------------"
" Set tags file
"set tags=.\tags
set complete=.,w,b,u,t,k
set completeopt=longest,menuone  "Complete up to longest set of characters, show menu even if only one option

" }}}

"  CtrlP {{{
"------------------------------------------------------------------------------"
"let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
        "\ --ignore .git
        "\ --ignore .svn
        "\ --ignore .hg
        "\ --ignore .DS_Store
        "\ --ignore "**/*.pyc"
        "\ -g ""'
"if !has('python')
        "echo 'In order to use pymatcher plugin, you need +python compiled vim'
"else
        "let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"endif
let g:ctrlp_by_filename = 0   " Search by filename (as opposed to full path)
let g:ctrlp_clear_cache_on_exit = 0 " 0 - Save cache on exiting VIM, 1 - clear cache
let g:ctrlp_custom_ignore = {
   \ 'dir': '\v[\/](\.git|_Intermediate|_IntermediateDebug|node_modules|packages)$',
   \ 'file': '\v\.(dll|exe|lib|lnk|obj|pdb|pdf|png|so)$',
   \ }
let g:ctrlp_dotfiles = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_lazy_update = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_depth = 12
let g:ctrlp_max_files = 20000
let g:ctrlp_max_height = 30
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_mruf_max = 250
let g:ctrlp_regexp = 1        " Search using regex
let g:ctrlp_switch_buffer = 0
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_working_path_mode = 0
nnoremap ;b :CtrlPBuffer<CR>
nnoremap ;f :CtrlP<CR>
nnoremap ;m :CtrlPMRUFiles<CR>
nnoremap ;t :CtrlPTag<CR>

" CtrlP Buffer Delete - Mark some with <c-z> and/or use <c-2> to delete
call ctrlp_bdelete#init()

" }}}

"  Tagbar {{{
"------------------------------------------------------------------------------"
nnoremap <leader>tag :TagbarToggle<CR>
let g:tagbar_sort = 0
if has('win32')
   let g:tagbar_ctags_bin = 'C:\bin\ctags.exe'
endif
" Uncommenting the below really slows down loading markdown files
"let g:tagbar_type_markdown = {
    "\ 'ctagstype' : 'markdown',
    "\ 'kinds' : [
        "\ 'h:Heading_L1',
        "\ 'i:Heading_L2',
        "\ 'k:Heading_L3'
    "\ ]
"\ }

" }}}

"  DoxygenToolkit {{{
"------------------------------------------------------------------------------"
let g:DoxygenToolkit_briefTag_pre=""
nnoremap <leader>doc :Dox<CR>

" }}}

"  Air-line {{{
"------------------------------------------------------------------------------"
set laststatus=2
" Uncommenting below overrides the default statusline B showing git branch information
"let g:airline_section_b = '0x%B'
let g:airline_section_c = '%F'
let g:airline_theme = 'murmur'

" }}}

"  Syntastic {{{
"------------------------------------------------------------------------------"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_eslint_exe = 'npm run lint --'

" Checkers for various file types
"let g:syntastic_cpp_checkers=['cppcheck']
let g:syntastic_javascript_checkers=['eslint']

" }}}

"  vimdiff {{{
"------------------------------------------------------------------------------"
set diffopt=filler,vertical

" }}}

"  simple-todo {{{
"------------------------------------------------------------------------------"
let g:simple_todo_map_normal_mode_keys = 1
let g:simple_todo_map_insert_mode_keys = 0
let g:simple_todo_map_visual_mode_keys = 1

" }}}

"  vimwiki {{{
"------------------------------------------------------------------------------"
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
nmap <Leader>di <Plug>VimwikiDiaryIndex
nmap <Leader>du <Plug>VimwikiDiaryGenerateLinks
nmap <Leader>dd <Plug>VimwikiMakeDiaryNote
nmap <Leader>dy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <Leader>dm <Plug>VimwikiMakeTomorrowDiaryNote

" }}}

"  omnicompletion {{{
"------------------------------------------------------------------------------"
set omnifunc=syntaxcomplete#Complete

" }}}

"  vim-instant-markdown {{{
"------------------------------------------------------------------------------"
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
nmap <leader>md :InstantMarkdownPreview<CR>

" }}}

autocmd FileType css vmap <buffer> = :call RangeCSSBeautify()<cr>

"hi markdownLinkText ctermbg=black
