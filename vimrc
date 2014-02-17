" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd        " Show (partial) command in status line.
set showmatch      " Show matching brackets.
"set ignorecase     " Do case insensitive matching
"set smartcase      " Do smart case matching
"set incsearch      " Incremental search
"set autowrite      " Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=a        " Enable mouse usage (all modes) in terminals
set cursorline

if has("autocmd") 
  " When editing a file, always jump to the last cursor position 
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

" fonctions tres pratiques
" enlève la coloration de la syntaxe
function! SyntaxToggle()
  if exists("g:syntax_on")
    syntax off
    echo "syntax off"
  else
    syntax on
    echo "syntax on"
  endif
"  execute "syntax" exists("g:syntax_on") ? "off" : "on"
endfunction

" limite de longueur d'une ligne
let g:tw = "0"
function! ToggleTexttWidth()
  if g:tw == "0"
    set textwidth=80
    let g:tw = "80"
  else
    set textwidth=0
    let g:tw = "0"
  endif
  echo "textwidth" &textwidth
endfunction

" permet de voir les lignes trop longues
let g:twe = "1"
function! ToggleTextWidthError()
  if g:twe == "0"
    match ErrorMsg /\%>80v.\+/
    let g:twe = "1"
    echo "text width error on"
  else
    match Normal /\%>80v.\+/
    let g:twe = "0"
    echo "text width error off"
  endif
endfunction

" coller
let g:paste = "0"
function! TogglePaste()
  if g:paste == "0"
    set paste
    let g:paste = "1"
    echo "paste on"
  else
    set nopaste
    let g:paste = "0"
    echo "paste off"
  endif
endfunction

"correcteur d'orthographe
let g:spell = "0"
function! ToggleSpell()
  if g:spell == "0"
    set spell
    let g:spell = "1"
    echo "spell on"
  else
    set nospell
    let g:spell = "0"
    echo "spell off"
  endif
endfunction

" Low priority filename suffixes for filename completion {{{ 
set suffixes-=.h        " Don't give .h low priority 
set suffixes+=~ 
set suffixes+=.swp 
set suffixes+=.o 
set suffixes+=.class 
" }}} 

" raccourcis
" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i
map <silent> <F3> :call TogglePaste()<CR>
map <silent> <F4> :call ToggleSpell()<CR>
map <silent> <F5> :call SyntaxToggle()<CR>
"map <silent> <F6> :call ToggleTextWidthError()<CR>
map <silent> <F6> ggVGg?
"map <silent> <F7> :call ToggleTexttWidth()<CR>
" cree une entete doxygen
map <F7> :Dox<CR>
" fait un make
map <F8> :!make<CR>
" goto definition with F9
map <F9> <C-]>
" fait un commit
map <F12> :!svn commit -m "

map <C-Tab> <C-V><Tab>

" colorscheme gentooish
colorscheme twilight256
set shiftwidth=2        
set autoindent      "auto indentation
set smartindent     "use intelligent indentation for C
set number          "numero de ligne
set tabstop=4       "nombre d'espace pour une tabulation
set shiftwidth=4    "> and < move block by 4 spaces in visual mode
set expandtab       "transforme les tabs en espaces
set spelllang=fr,en "langues utilisees
set hlsearch        "hilight les recherches
"set textwidth=80    "coupe le texte a 80 caractere, quand on l'ecrit seulement
set vb t_vb=        "enleve les beep
set wildmenu        "met une liste des fichiers quand on en cherche un
set t_Co=256        "256 couleurs utilisees



" permet de hilight les lignes de plus de 80 caracteres dans tout types de
"fichier
":au BufWinEnter *.c,*.h let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
":au BufWinEnter *.c,*.h let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
let g:tex_flavor='latex'
filetype plugin on

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
