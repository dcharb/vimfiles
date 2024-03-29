set nocompatible     " Configure for VIM instead of VI
let mapleader = ","  "set <leader> to ','

set fdm=marker  " Set folding type as marker. This allows vimrc to use comments for folding.

"  VIM-PLUG {{{
"------------------------------------------------------------------------------"

if has('win32')
   call plug#begin('$HOME\vimfiles\plugged')
elseif has('unix')
   call plug#begin('$HOME/.vim/plugged')
endif

" All plugins defined between #begin and #end
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'aklt/plantuml-syntax'
"Plug 'altercation/vim-colors-solarized'
Plug 'dense-analysis/ale'
Plug 'einars/js-beautify'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'idanarye/vim-merginal'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-operator-user'
Plug 'leafgarland/typescript-vim'
"Plug 'lifepillar/vim-solarized8'
"Plug 'posva/vim-vue'
Plug 'preservim/tagbar'
Plug 'maksimr/vim-jsbeautify'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'mileszs/ack.vim'
"Plug 'noahfrederick/vim-noctu'
Plug 'rhysd/vim-clang-format'
Plug 'scrooloose/nerdcommenter'
Plug 'sk1418/QFGrep'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'will133/vim-dirdiff'
Plug 'yuezk/vim-js'

call plug#end()

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
   colors slate
endif
syntax on                        " Turn on syntax highlighting
if has('win32')
   set guifont=Consolas:h11   " Set the font
   "au GUIEnter * simalt ~x          " Maximize window on startup
endif

" SpellBad is too hard to read - change it
hi SpellBad cterm=underline ctermbg=none

"hi Comment cterm=none   "Remove italic highlighting
"hi CursorLine ctermbg=8 "Set background to light gray
"hi ColorColumn ctermbg=darkgrey

" Highlight the current word everywhere
hi SameWord guifg=LightGray ctermfg=Brown
autocmd CursorMoved * exe printf('match SameWord /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" Change cursor shape for iTerm on Mac
if $TERM_PROGRAM =~ "iTerm"
   let &t_SI = "\<Esc>]50;CursorShape=1\x7" "Vertical bar insert mode
   let &t_EI = "\<Esc>]50;CursorShape=0\x7" "Block bar normal mode
endif

" Make warning messages a little more visible
"hi WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None

" }}}

"  WINDOW SETUP {{{
"------------------------------------------------------------------------------"
" Show the line numbers and column
set number
set ruler
set nowrap       " Wrap text on screen
set linebreak  " Wrap on characters in the breakat option. ie: space, tab, etc
set textwidth=120 " Wrap text at this column
"set colorcolumn=+1   " Show the max column as a different colour at textwidth+1

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

" Alternative to ESC key
inoremap ;; <ESC>

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
set shiftwidth=2     " Number of spaces for autoindent
set tabstop=2        " How many spaces a tab is

" Allow backspace to go over autoindent, end of previous line, and before the
" start of where you started your insert
set backspace=indent,eol,start

set viminfo='500,<50,s10,h " Remember last 500 recent files
set history=100            " Remember many commands and search history
set undolevels=100         " Number of undo levels

" Ignore some file extensions when opening files
set wildignore+=*/.git/*,*.swp,*.bak
set wildmenu
set wildmode=longest,list
set conceallevel=0

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
"au FileType markdown setlocal spell spelllang=en_ca   " Spell checking on for Canadian english
au FileType markdown setlocal shiftwidth=2
let g:markdown_fenced_languages = ['html', 'javascript' ]

" CODE
" Remove auto-commenting a new line in a *.c or *.cpp file
au FileType c,cpp setlocal comments-=:// comments+=f://
au FileType c,cpp map <buffer> = <Plug>(operator-clang-format)

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

nnoremap <leader>json :%!python -m json.tool<CR>

" }}}

"  Syntax highlight group {{{
"------------------------------------------------------------------------------"
nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" }}}

" PLUGINS {{{

"  ack.vim {{{

" Use ripgrep for searching
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --type-not gzip --smart-case --hidden'

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>

" }}}

"  Air-line {{{
"------------------------------------------------------------------------------"
set laststatus=2
" Uncommenting below overrides the default statusline B showing git branch information
"let g:airline_section_b = '0x%B'
"let g:airline_section_b = '%{getcwd()}'
"let g:airline_section_b = '%{FugitiveStatusline()}'
let g:airline_section_c = '%F'
let g:airline_theme = 'luna'
let g:airline_powerline_fonts = 1

" }}}

" Clang Format {{{
"let g:clang_format#command="c:\program files\llvm\bin\clang-format"
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

"  FZF {{{
"------------------------------------------------------------------------------"
if has('unix')
   set rtp+=/usr/local/opt/fzf
endif
let g:fzf_layout = { 'down': '90%' }
let g:fzf_preview_window = ['up:90%:hidden', 'ctrl-/']
nnoremap ;b :Buffers<CR>
nnoremap ;t :Tags<CR>
nnoremap ;m :History<CR>
nnoremap ;f :Files<CR>
nnoremap <c-f> :BLines

" }}}

"  omnicompletion {{{
"------------------------------------------------------------------------------"
set omnifunc=syntaxcomplete#Complete

" }}}

"  Pandoc {{{
"------------------------------------------------------------------------------"
nnoremap <leader>pdf :!pandoc -f markdown -t latex -o %<.pdf --toc -V geometry:margin=1in %<CR>
nnoremap <leader>html :!pandoc -f markdown -t html5 -o %<.html --toc %<CR>
nnoremap <leader>word :!pandoc -f markdown -t docx -o %<.docx --toc %<CR>

" }}}

"  simple-todo {{{
"------------------------------------------------------------------------------"
let g:simple_todo_map_normal_mode_keys = 1
let g:simple_todo_map_insert_mode_keys = 0
let g:simple_todo_map_visual_mode_keys = 1

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

"  vim-instant-markdown {{{
"------------------------------------------------------------------------------"
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
nmap <leader>md :InstantMarkdownPreview<CR>

" }}}

"  vimdiff {{{
"------------------------------------------------------------------------------"
set diffopt=filler,vertical

" }}}

"  vim-terraform {{{
"------------------------------------------------------------------------------"
let g:terraform_fmt_on_save=1

" }}}

"  vimwiki {{{
"------------------------------------------------------------------------------"
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_conceallevel = 0
nmap <Leader>di <Plug>VimwikiDiaryIndex
nmap <Leader>du <Plug>VimwikiDiaryGenerateLinks
nmap <Leader>dd <Plug>VimwikiMakeDiaryNote
nmap <Leader>dy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <Leader>dm <Plug>VimwikiMakeTomorrowDiaryNote

" }}}

" }}}

autocmd FileType css vmap <buffer> = :call RangeCSSBeautify()<cr>

set rtp+=$HOME/vimfiles-corporate
