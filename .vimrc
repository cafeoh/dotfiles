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
set background=dark

"execute pathogen#infect()

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
"set mouse=a        " Enable mouse usage (all modes) in terminals

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
"set listchars=tab:▸\ ,eol:¬
set listchars=tab:▸\
set list

if has("autocmd") 
  " When editing a file, always jump to the last cursor position 
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

" Low priority filename suffixes for filename completion {{{ 
set suffixes-=.h        " Don't give .h low priority 
set suffixes+=~ 
set suffixes+=.swp 
set suffixes+=.o 
set suffixes+=.class 
" }}} 

set shiftwidth=2        
set autoindent      "auto indentation
set smartindent     "use intelligent indentation for C
set number          "numero de ligne
set tabstop=4       "nombre d'espace pour une tabulation
set shiftwidth=4    "> and < move block by 4 spaces in visual mode
set expandtab       "transforme les tabs en espaces
set spelllang=fr,en "langues utilisees
"set hlsearch        "hilight les recherches
"set textwidth=80    "coupe le texte a 80 caractere, quand on l'ecrit seulement
set vb t_vb=        "enleve les beep
set wildmenu        "met une liste des fichiers quand on en cherche un
set t_Co=256        "256 couleurs utilisees
"hi Normal ctermbg=none

"w!! to reopen with sudo and save
cmap w!! w !sudo tee % >/dev/null

"  CYGWIN/MSYS support
" set bs=2 " Proper backspace behavior
" let &t_ti.="\e[1 q" "^
" let &t_SI.="\e[5 q" "| Block cursor
" let &t_EI.="\e[1 q" "| instead of bar
" let &t_te.="\e[0 q" "v

" Q short for ex mode is bane of azerty/qwerty switchers
nnoremap Q <nop>


" GIT GUD PUNK
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>


colorscheme gruvbox
hi Normal ctermbg=none

filetype plugin on
