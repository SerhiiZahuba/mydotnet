
" MY VIM CONF

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "

" Fast saving
nmap <leader>w :w!<cr>

" Open file explorer
nmap <Leader>e :Explore<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Reload vim conf
nmap <Leader>r :source ~/.vimrc<cr>

" Set regular expression engine automatically
set regexpengine=0

" Set faster update time
set updatetime=250

" Add a bit extra margin to the left
" set foldcolumn=1

""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""
" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Enable 256 colors palette
set t_Co=256

" Try loading theme
try
    colorscheme habamax
catch
endtry

set background=dark

" Set relative line numbers
set number
set relativenumber

" Set encoding
set encoding=utf-8

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Use undo files instead of swap files
set mouse=a
set nobackup
set nowb
set noswapfile
set history=500
" Create undo directory if it does not exist
if !isdirectory($HOME . "/.vim/undo")
    call mkdir($HOME . "/.vim/undo", "p", 0700)
endif
set undodir=$HOME/.vim/undo
set undofile

" Turn on the Wild menu
set wildmenu
set wildmode=longest:full,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime
" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Set indent line
set autoindent

" Auto intent on file write for some files
autocmd BufRead,BufWritePre *.sh normal gg=G

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=4

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Enable syntax highlighting
syntax enable

" Enable filetype plugins
filetype plugin on
filetype indent on

" Language settings
autocmd FileType yaml setlocal ts=2 sts=2 sw=2

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Tmux-like shortcuts for tabs
map <leader>tc :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabmove
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

""""""""""""""""""""""""""""""
" => Editing mappings
""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk]
nnoremap <leader>k :move-2<CR>==
nnoremap <leader>j :move+<CR>==
xnoremap <leader>k :move-2<CR>gv=gv
xnoremap <leader>j :move'>+<CR>gv=gv

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" Delete trailing spaces on save
if has("autocmd")
   autocmd BufWritePre *.yaml,*.txt,*.js,*.py,*.html,*.sh,*.md,*.vim* :call CleanExtraSpaces()
endif

" Manually format trailing spaces
map <leader>t :call CleanExtraSpaces()<cr>

" Indent
map <leader>i gg=G

""""""""""""""""""""""""""""""
" => Spell checking
""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


""""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>n :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>m :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

""""""""""""""""""""""""""""""
" => Helper functions
""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

" Load plugins if .vimrc.plug is present
if filereadable(expand("~/.vimrc.plug"))

    " Check if plug ins installed
    if !filereadable(expand("~/.vim/autoload/plug.vim"))
        :! curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif

    " Source plug file
    source ~/.vimrc.plug

    " Set plugin theme
    colorscheme nord

    " Load plugin settings
    " Integrate airline with ale
    let g:airline#extensions#ale#enabled = 1
    " Intent line plugin style
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1

    " Git changes toggle
    map <leader>gg :GitGutterToggle<cr>
    map <leader>gh :GitGutterLineHighlightsToggle<cr>
    " Git shortcuts
    map ]h :GitGutterNextHunk<cr>
    map [h :GitGutterPrevHunk<cr>
    map <leader>hs :GitGutterStageHunk<cr>
    map <leader>hu :GitGutterLineHighlightsToggle<cr>

    " Terminal
    map <leader>tf :FloatermNew --height=0.7 --width=0.9<cr>
    map <F7> :FloatermNew --height=0.7 --width=0.9<cr>
    map <leader>ts :FloatermNew --wintype=normal --position=bottom<cr>
    map <leader>tv :FloatermNew --wintype=normal --position=right<cr>
    map <leader>tt :FloatermNew --height=0.7 --width=0.9 btm<cr>
    map <leader>th :FloatermNew --height=0.7 --width=0.9 htop<cr>

    " Fuzzy finder with float term
    map <leader>ff :FloatermNew --height=0.6 --width=0.8 fzf<cr>
endif

