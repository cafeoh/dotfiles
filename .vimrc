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

execute pathogen#infect()

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
set ignorecase     " Ignore case by default
set smartcase      " Do smart case matching, overrides but needs ignorecase
"set incsearch      " Incremental search
"set autowrite      " Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a        " Enable mouse usage (all modes) in terminals
set title		  " Title is document's name

let leader = "<Space>"

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
vnoremap <leader>y \"+y
vnoremap <leader>/ y/<C-R>"<CR>
" Use the same symbols as TextMate for tabstops and EOLs
"set listchars=tab:▸\ ,eol:¬
"set listchars=tab:▸\
"set list
"
vnoremap // "vy/v<CR>

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
set hlsearch        "hilight les recherches
"set textwidth=80    "coupe le texte a 80 caractere, quand on l'ecrit seulement
set vb t_vb=        "enleve les beep
set wildmenu        "met une liste des fichiers quand on en cherche un
set t_Co=256        "256 couleurs utilisees
"hi Normal ctermbg=none

set scrolloff=5

map <F12> :set invhls<CR>

"w!! to reopen with sudo and save
cmap w!! w !sudo tee % >/dev/null

" GIT GUD PUNK
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>


colorscheme gruvbox
"colorscheme base16-default-dark
hi Normal ctermbg=none

filetype plugin on

map <F7> :w !xclip -sel c<CR><CR>

set path=$PWD/**

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <CR> :noh<CR>

"let g:BASH_Ctrl_j = 'off'
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

" Look up the root for a cscope.out
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()
