".vimrc
" Author: Maxime Cogney <cogney.maxime@gmail.com>
" Mostly uses bit chunks from Steve Losh's vimrc (bitbucket.org/sjl)
"
" Preamble ---------------------------------------------------------------- {{{
"
set shell=/bin/bash\ --login

set nocompatible
filetype off
call pathogen#infect()
filetype plugin indent on

" }}}
" Basic options ----------------------------------------------------------- {{{

set modelines=0
set autoindent
set showmode
set showcmd
set hidden
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set number
set norelativenumber
set laststatus=2
set history=1000
set undofile
set undoreload=10000
"set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set lazyredraw
set matchtime=3
set showbreak=↪
set splitbelow
set splitright
set autowrite
set autoread
set shiftround
set title
set linebreak
set colorcolumn=+1
set diffopt+=vertical

" iTerm2 is currently slow as balls at rendering the nice unicode lines, so for
" now I'll just use ASCII pipes.  They're ugly but at least I won't want to kill
" myself when trying to move around a file.
set fillchars=diff:⣿,vert:│
"set fillchars=diff:⣿,vert:\|

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

" Save when losing focus
"au FocusLost * :silent! wall

" Resize splits when the window is resized
 au VimResized * :wincmd =

" Leader
let mapleader = ","
let maplocalleader = "\\"

" Cursorline {{{
" Only show cursorline in the current window and in normal mode.

augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" }}}
" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}
" Wildmenu completion {{{

set wildmenu
set wildmode=list:longest

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files

set wildignore+=*.pyc                            " Python byte code

set wildignore+=*.orig                           " Merge resolution files

" }}}
" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" Tabs, spaces, wrapping {{{

set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set textwidth=0
set formatoptions=qrn1j
set colorcolumn=+0

" }}}
" Backups {{{

set backup                        " enable backups
set noswapfile                    " it's 2013, Vim. (No it's really not)

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}
" Color scheme {{{

syntax on
"set termguicolors
set background=dark
"let g:badwolf_tabline = 2
"let g:badwolf_html_link_underline = 0
"colorscheme badwolf

colorscheme gruvbox
hi Normal ctermbg=none

" Reload the colorscheme whenever we write the file.
"augroup color_badwolf_dev
"    au!
"    au BufWritePost badwolf.vim color badwolf
"    "au BufWritePost goodwolf.vim color goodwolf
"augroup END

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" }}}
" Convenience mappings ---------------------------------------------------- {{{

" Fuck you, help key.
noremap  <F1> :checktime<cr>
inoremap <F1> <esc>:checktime<cr>

" Stop it, hash key.
inoremap # X<BS>#

" Kill window
"nnoremap K :q<cr>

" Save
nnoremap s :w<cr>

" Man
nnoremap M K

" Clean up windows
nnoremap - :wincmd =<cr>

" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

" Sort lines
nnoremap <leader>s vip:sort<cr>
vnoremap <leader>s :sort<cr>

" Tabs
nnoremap <leader>( :tabprev<cr>
nnoremap <leader>) :tabnext<cr>

" My garbage brain can't ever remember digraph codes
inoremap <c-k><c-k> <esc>:help digraph-table<cr>

" Wrap
nnoremap <leader>W :set wrap!<cr>

" Inserting blank lines
" I never use the default behavior of <cr> and this saves me a keystroke...
nnoremap <cr> o<esc>

" Copying/pasting text to the system clipboard.
noremap  <leader>p "+p
vnoremap <leader>y "+y
nnoremap <leader>y VV"+y
nnoremap <leader>Y "+y

" Yank to end of line
nnoremap Y y$

" Reselect last-pasted text
nnoremap gv `[v`]

" I constantly hit "u" in visual mode when I mean to "y". Use "gu" for those rare occasions.
" From https://github.com/henrik/dotfiles/blob/master/vim/config/mappings.vim
"vnoremap u <nop>
"vnoremap gu u

" Rebuild Ctags (mnemonic RC -> CR -> <cr>)
nnoremap <leader><cr> :silent !myctags >/dev/null 2>&1 &<cr>:redraw!<cr>

" Highlight Group(s)
nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Send visual selection to paste.stevelosh.com
"vnoremap <leader>P :w !pb && open `pbpaste`<cr>

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" Fix from spellcheck
" I can never remember if it's zg or z=, and the wrong one adds the word to
" the DB (lol), so fuck it, just add an easier mapping.
"nnoremap zz z=
"nnoremap z= :echo "use zz you idiot"<cr>

" "Uppercase word" mapping.
"
" This mapping allows you to press <c-u> in insert mode to convert the current
" word to uppercase.  It's handy when you're writing names of constants and
" don't want to use Capslock.
"
" To use it you type the name of the constant in lowercase.  While your
" cursor is at the end of the word, press <c-u> to uppercase it, and then
" continue happily on your way:
"
"                            cursor
"                            v
"     max_connections_allowed|
"     <c-u>
"     MAX_CONNECTIONS_ALLOWED|
"                            ^
"                            cursor
"
" It works by exiting out of insert mode, recording the current cursor location
" in the z mark, using gUiw to uppercase inside the current word, moving back to
" the z mark, and entering insert mode again.
"
" Note that this will overwrite the contents of the z mark.  I never use it, but
" if you do you'll probably want to use another mark.
inoremap <C-u> <esc>mzgUiw`za

" Panic Button
nnoremap <f9> mzggg?G`z

" zt is okay for putting something at the top of the screen, but when I'm
" writing prose I often want to put something at not-quite-the-top of the
" screen.  zh is "zoom to head level"
nnoremap zh mzzt10<c-u>`z

" Diffoff
nnoremap <leader>D :diffoff!<cr>

" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq

" Reformat line.
" I never use l as a macro register anyway.
nnoremap ql gqq

" Indent/dedent/autoindent what you just pasted.
nnoremap <lt>> V`]<
nnoremap ><lt> V`]>
nnoremap =- V`]=

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Join an entire paragraph.
"
" Useful for writing GitHub comments in actual Markdown and then translating it
" to their bastardized version of Markdown.
nnoremap <leader>j mzvipJ`z

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
"nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Substitute
nnoremap <c-s> :%s/
vnoremap <c-s> :s/

" HTML tag closing
"inoremap <C-_> <space><bs><esc>:call InsertCloseTag()<cr>a

" Marks and Quotes
"noremap ' `
"noremap æ '
"noremap ` <C-^>

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_

" Typos
"command! -bang E e<bang>
"command! -bang Q q<bang>
"command! -bang W w<bang>
"command! -bang QA qa<bang>
"command! -bang Qa qa<bang>
"command! -bang Wa wa<bang>
"command! -bang WA wa<bang>
"command! -bang Wq wq<bang>
"command! -bang WQ wq<bang>
"command! -bang Wqa wqa<bang>

" Unfuck my screen
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" Pushing
"nnoremap <leader>Go :Start! git push origin<cr>
"nnoremap <leader>Gu :Start! git push upstream<cr>

" Open current directory in Finder
"nnoremap <leader>O :!open .<cr>

" Zip Right
"
" Moves the character under the cursor to the end of the line.  Handy when you
" have something like:
"
"     foo
"
" And you want to wrap it in a method call, so you type:
"
"     println()foo
"
" Once you hit escape your cursor is on the closing paren, so you can 'zip' it
" over to the right with this mapping.
"
" This should preserve your last yank/delete as well.
nnoremap zl :let @z=@"<cr>x$p:let @"=@z<cr>

" Indent from insert mode
" has to be imap because we want to be able to use the "go-indent" mapping
imap <c-l> <c-o>gi

" Diff Navigation
nnoremap dn ]c
nnoremap dN [c

" Insert Mode Completion {{{

inoremap <c-f> <c-x><c-f>
inoremap <c-]> <c-x><c-]>
inoremap <c-l> <c-x><c-l>

" }}}

" Window Resizing {{{
" right/up : bigger
" left/down : smaller
nnoremap <m-right> :vertical resize +3<cr>
nnoremap <m-left> :vertical resize -3<cr>
nnoremap <m-up> :resize +3<cr>
nnoremap <m-down> :resize -3<cr>
" }}}

" }}}
" Quick editing ----------------------------------------------------------- {{{

nnoremap <leader>eg :vsplit ~/.gitconfig<cr>
nnoremap <leader>ev :vsplit ~/.vimrc<cr>

" }}}
" Searching and movement -------------------------------------------------- {{{

" Use sane regexes.
" nnoremap / /\v
" vnoremap / /\v

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set scrolloff=5
set sidescroll=1
set sidescrolloff=10

set virtualedit+=block

noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

"runtime macros/matchit.vim
"noremap <tab> %
"noremap <c-i> <tab>
"silent! unmap [%
"silent! unmap ]%

" Made D behave
nnoremap D d$

" Don't move on *
" I'd use a function for this but Vim clobbers the last search when you're in
" a function so fuck it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Jumping to tags.
"
" Basically, <c-]> jumps to tags (like normal) and <c-\> opens the tag in a new
" split instead.
"
" Both of them will align the destination line to the upper middle part of the
" screen.  Both will pulse the cursor line so you can see where the hell you
" are.  <c-\> will also fold everything in the buffer and then unfold just
" enough for you to see the destination line.
"
function! JumpTo(jumpcommand)
    execute a:jumpcommand
    call FocusLine()
    Pulse
endfunction
function! JumpToInSplit(jumpcommand)
    execute "normal! \<c-w>v"
    execute a:jumpcommand
    Pulse
endfunction

function! JumpToTag()
    call JumpTo("normal! \<c-]>")
endfunction
function! JumpToTagInSplit()
    call JumpToInSplit("normal! \<c-]>")
endfunction

"nnoremap <c-]> :silent! call JumpToTag()<cr>
"nnoremap <c-\> :silent! call JumpToTagInSplit()<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" Directional Keys {{{

" It's 2013. (Still isn't)
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>v <C-w>v

" }}}
" Visual Mode */# from Scrooloose {{{

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" }}}
" List navigation {{{

nnoremap <left>  :cprev<cr>zvzz
nnoremap <right> :cnext<cr>zvzz
nnoremap <up>    :lprev<cr>zvzz
nnoremap <down>  :lnext<cr>zvzz

" }}}

" }}}
" Folding ----------------------------------------------------------------- {{{

set foldlevelstart=99

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a bit (25 lines) down from the top of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
"
" I use :sus for the rare times I want to actually background Vim.
function! FocusLine()
    let oldscrolloff = &scrolloff
    set scrolloff=0
    execute "keepjumps normal! mzzMzvzt25\<c-y>`z:Pulse\<cr>"
    let &scrolloff = oldscrolloff
endfunction
nnoremap <c-z> :call FocusLine()<cr>

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}
" Filetype-specific ------------------------------------------------------- {{{

" Arduino {{{

augroup ft_arduino
    au!

    au FileType arduino setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8 foldmethod=syntax
    au FileType arduino inoremap <buffer> ☃ <esc>A;<cr>
    au FileType arduino inoremap <buffer> ☂ <esc>mzA;<esc>`z
augroup END

" }}}
" Assembly {{{

augroup ft_asm
    au!
    au FileType asm setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8
augroup END

" }}}
" C {{{

augroup ft_c
    au!
    au FileType c setlocal foldmethod=marker foldmarker={,}
    "au FileType c setlocal ts=8 sts=8 sw=8 noexpandtab
augroup END

" }}}
" C++ {{{

augroup ft_cpp
    au!
    au FileType cpp setlocal foldmethod=marker foldmarker={,}
    "au FileType cpp setlocal ts=8 sts=8 sw=8 noexpandtab
augroup END

" }}}
" C# {{{

let g:OmniSharp_selector_ui = 'ctrlp'

augroup ft_csharp
    au!
    au FileType cs setlocal foldmethod=marker foldmarker={,}
    au FileType cs setlocal ts=4 sts=4 sw=4 expandtab
    au FileType cs setlocal foldtext=MyFoldText()
    " au FileType cs inoremap <c-n> <c-x><c-o>

    au FileType cs nnoremap <buffer> <c-]> :OmniSharpGotoDefinition<cr>
    au FileType cs nnoremap <buffer> M :OmniSharpDocumentation<cr>

    au FileType cs nnoremap <buffer> gi mz=ap`z

    au FileType cs setlocal ts=4 sw=4 sts=4 noexpandtab
augroup END

" }}}
" CSS and LessCSS {{{

augroup ft_css
    au!

    au BufNewFile,BufRead *.less setlocal filetype=less

    au Filetype less,css setlocal foldmethod=marker
    au Filetype less,css setlocal foldmarker={,}
    au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype less,css setlocal iskeyword+=-

    " Use <localleader>S to sort properties.  Turns this:
    "
    "     p {
    "         width: 200px;
    "         height: 100px;
    "         background: red;
    "
    "         ...
    "     }
    "
    " into this:

    "     p {
    "         background: red;
    "         height: 100px;
    "         width: 200px;
    "
    "         ...
    "     }
    au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END

" }}}
" Diff {{{

" This is from https://github.com/sgeb/vim-diff-fold/ without the extra
" settings crap.  Just the folding expr.

function! DiffFoldLevel()
    let l:line=getline(v:lnum)

    if l:line =~# '^\(diff\|Index\)'     " file
        return '>1'
    elseif l:line =~# '^\(@@\|\d\)'  " hunk
        return '>2'
    elseif l:line =~# '^\*\*\* \d\+,\d\+ \*\*\*\*$' " context: file1
        return '>2'
    elseif l:line =~# '^--- \d\+,\d\+ ----$'     " context: file2
        return '>2'
    else
        return '='
    endif
endfunction

augroup ft_diff
    au!

    autocmd FileType diff setlocal foldmethod=expr
    autocmd FileType diff setlocal foldexpr=DiffFoldLevel()
augroup END

" }}}
" DTrace {{{

augroup ft_dtrace
    au!

    autocmd BufNewFile,BufRead *.d set filetype=dtrace
augroup END

" }}}
" GLSL {{{

augroup ft_glsl
    au!

    au BufNewFile,BufRead *.shader setlocal filetype=glsl

    au FileType glsl setlocal foldmethod=marker foldmarker={,}
    au FileType glsl setlocal ts=8 sts=8 sw=8 noexpandtab
augroup END

" }}}
" Java {{{

augroup ft_java
    au!

    au FileType java setlocal foldmethod=marker
    au FileType java setlocal foldmarker={,}
    au FileType java inoremap <c-n> <c-x><c-]>
augroup END

" }}}
" Javascript {{{

augroup ft_javascript
    au!

    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
    au FileType javascript call MakeSpacelessBufferIabbrev('clog', 'console.log();<left><left>')

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
    " }

    " Prettify a hunk of JSON with <localleader>p
    au FileType javascript nnoremap <buffer> <localleader>p ^vg_:!python -m json.tool<cr>
    au FileType javascript vnoremap <buffer> <localleader>p :!python -m json.tool<cr>
augroup END

" }}}
" Latex {{{

let g:tex_flavor = 'latex'

augroup ft_latex
    au!
augroup END

" }}}
" Mail {{{

augroup ft_mail
    au!

    au Filetype mail setlocal spell
    au FileType mail setlocal textwidth=72
augroup END

" }}}
" Makefile {{{

augroup ft_make
    au!

    au Filetype make setlocal shiftwidth=8
augroup END

" }}}
" Markdown {{{

augroup ft_markdown
    au!

    au BufNewFile,BufRead *.m*down setlocal filetype=markdown foldlevel=1

    au Filetype markdown setlocal spell

    " Linkify selected text inline to contents of pasteboard.
    au Filetype markdown vnoremap <buffer> <localleader>l <esc>`>a]<esc>`<i[<esc>`>lla()<esc>"+P

    " Use <localleader>1/2/3 to add headings.
    au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>3 mzI###<space><esc>`zllll
    au Filetype markdown nnoremap <buffer> <localleader>4 mzI####<space><esc>`zlllll
augroup END

" }}}
" Python {{{

function! SelectTopLevelPythonHunk() "{{{
    " oh darling what have I done

    " if we're on toplevel line that ends in a :, drop down one line before
    " we move on.  this is bad and i feel bad.
    let line = getline(".")
    if len(line) > 0 && line[0] != " " && line[len(line) - 1] == ":"
        normal! j
    endif

    normal! v

    " use the non-bang version of normal here because we need to use the
    " indentation script.  this is also bad and i still feel bad.
    normal ai

    " keep chomping upwards in the indentation stack til we get to something
    " that's at the top level.  its bad.
    while getline(".")[0] == " "
        normal ai
    endwhile
endfunction "}}}

function! OpenPythonRepl() "{{{
    "fucking kill me
    NeoRepl fish
endfunction "}}}
function! SendPythonLine() "{{{
    let view = winsaveview()

    execute "normal! ^vg_\<esc>"
    call NeoReplSendSelection()

    call winrestview(view)
endfunction "}}}
function! SendPythonParagraph() "{{{
    let view = winsaveview()

    execute "normal! ^vip\<esc>"
    call NeoReplSendSelection()

    call winrestview(view)
endfunction "}}}
function! SendPythonTopLevelHunk() "{{{
    let view = winsaveview()
    let old_z = @z

    call SelectTopLevelPythonHunk()
    normal! gv"zy
    call NeoReplSendRaw("%cpaste\n" . @z . "\n--\n")

    let @z = old_z
    call winrestview(view)
endfunction "}}}
function! SendPythonSelection() "{{{
    let view = winsaveview()
    let old_z = @z

    normal! gv"zy
    call NeoReplSendRaw("%cpaste\n" . @z . "\n--\n")

    let @z = old_z
    call winrestview(view)
endfunction "}}}
function! SendPythonBuffer() "{{{
    let view = winsaveview()

    execute "normal! ggVG\<esc>"

    normal! gv"zy
    call NeoReplSendRaw("%cpaste\n" . @z . "\n--\n")

    call winrestview(view)
endfunction "}}}

augroup ft_python
    au!

    au FileType python setlocal define=^\s*\\(def\\\\|class\\)

    " Jesus tapdancing Christ, built-in Python syntax, you couldn't let me
    " override this in a normal way, could you?
    au FileType python if exists("python_space_error_highlight") | unlet python_space_error_highlight | endif

    " Strip REPL-session marks from just-pasted text
    au FileType python nnoremap <localleader>s mz`[v`]:v/\v^(\>\>\>\|[.][.][.])/d<cr>gv:s/\v^(\>\>\> \|[.][.][.] \|[.][.][.]$)//<cr>:noh<cr>`z

    " Set up some basic neorepl mappings.
    "
    " key  desc                   mnemonic
    " \o - connect neorepl        [o]pen repl
    " \l - send current line      [l]ine
    " \p - send current paragraph [p]aragraph
    " \e - send top-level hunk    [e]val
    " \e - send selected hunk     [e]val
    " \r - send entire file       [r]eload file
    " \c - send ctrl-l            [c]lear

    au FileType python nnoremap <buffer> <silent> <localleader>o :call OpenPythonRepl()<cr>

    " Send the current line to the REPL
    au FileType python nnoremap <buffer> <silent> <localleader>l :call SendPythonLine()<cr>

    " Send the current paragraph to the REPL
    au FileType python nnoremap <buffer> <silent> <localleader>p :call SendPythonParagraph()<cr>

    " " Send the current top-level hunk to the REPL
    au FileType python nnoremap <buffer> <silent> <localleader>e :call SendPythonTopLevelHunk()<cr>

    " Send the current selection to the REPL
    au FileType python vnoremap <buffer> <silent> <localleader>e :<c-u>call SendPythonSelection()<cr>

    " Send the entire buffer to the REPL ([r]eload)
    au FileType python nnoremap <buffer> <silent> <localleader>r :call SendPythonBuffer()<cr>

    " Clear the REPL
    au FileType python nnoremap <buffer> <silent> <localleader>c :call NeoReplSendRaw("")<cr>
augroup END

" }}}
" Vim {{{

augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker keywordprg=:help
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif

    au FileType vim vnoremap <localleader>S y:@"<CR>
    au FileType vim nnoremap <localleader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

    au FileType vim inoremap <c-n> <c-x><c-n>
augroup END

" }}}
" XML {{{

augroup ft_xml
    au!

    au FileType xml setlocal foldmethod=manual

    " Use <localleader>f to fold the current tag.
    au FileType xml nnoremap <buffer> <localleader>f Vatzf

    " Indent tag
    au FileType xml nnoremap <buffer> <localleader>= Vat=
augroup END

" }}}

" }}}
" Pulse Line {{{

function! s:Pulse() " {{{
    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    let steps = 8
    let width = 1
    let start = width
    let end = steps * width
    let color = 233

    for i in range(start, end, width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor
    for i in range(end, start, -1 * width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor

    execute 'hi ' . old_hi
endfunction " }}}
command! -nargs=0 Pulse call s:Pulse()

" }}}
