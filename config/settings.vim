" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    settings.vim                                       :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: cmercier <cmercier@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2019/04/10 16:24:32 by cmercier          #+#    #+#              "
"    Updated: 2019/05/07 18:45:59 by cmercier         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

"-------------------------------------------------------------------------------
"								GENERAL SETTINGS
"-------------------------------------------------------------------------------
filetype plugin on
syntax on
colorscheme xoria256
set t_Co=256
set nobackup 					" no *~ backup files
set noswapfile
set nowritebackup

set mouse=a						"boon mode on
set number						"display current line number
set relativenumber				"display line number relative to current
set noshowmode 					"lightline already displays mode
set cursorline					"highlight screen line
set shortmess+=I				"hide launch screen
set ruler						"display cursor position in status bar
set nowrap						"don't wrap lines
set scrolloff=3					"keep x lines off the edges of the screen
set autoread					"automatically reload files changed outside VIM
set history=1000				"keep many muchos levels of command line history
set undolevels=1000				"use many muchos levels of undo
set laststatus=2				"tell VIM to always put a status line

set autoindent					"copies current line indenting
set smartindent					"іndenting behaviour for multiple languages
set smarttab					"insert tabs on the start of a line according to context

set hlsearch					"highlight search terms
set incsearch					"search while typing
set ignorecase					"ignore case when searching
set smartcase					"ignore case if search pattern is all lowercase,
								"	case-sensitive otherwise
set gdefault					"search/replace on a line
set showmatch					"set show matching parenthesis/bracket

set backspace=indent,eol,start	"allow backspacing over everything in insert
set textwidth=80				"limit line width
set colorcolumn=+1				"color said limit line
set clipboard+=unnamed			"normal OS clipboard interaction

" Tab completion
" " will insert tab at beginning of line,
" " will use completion if not at beginning

set wildmenu					"wild char completion menu
set wildmode=list:longest,list:full
set wildignore=*.o				"ignore .o files
set path+=**					"fuzzyfind like path selection
function! InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<Tab>"
	else
		return "\<C-p>"
	endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

set splitright					"vertical splits on right side
set splitbelow					"horizontal splits on bottom side

" disable sound on errors
set noerrorbells 
set visualbell 
set t_vb=
set nrformats=                  "make <C-a> and <C-x> play well with
                                "   zero-padded numbers (i.e. don't consider
								"	them octal or hex)

au FocusLost * :wa				"save all on losing focus

"-------------------------------------------------------------------------------
"									HOTKEYS
"-------------------------------------------------------------------------------

"open and source settings.vim
nnoremap <silent> <leader>ev :sp ~/.vim/config/settings.vim<cr>
nnoremap <silent> <leader>sv :so ~/.vim/config/settings.vim<cr>

"use shift-H and shift-L for home/end
nnoremap H ^
nnoremap L $

"<leader>g generates the header guard
map <leader>g :call IncludeGuard()<CR>
fun! IncludeGuard()
	let basename = substitute(bufname(""), '.*/', '', '')
	let guard = substitute(toupper(basename), '\.', '_', "H")
	call append(12, "#ifndef " . guard)
	call append(13, "# define " . guard)
	call append(line("$"), "#endif " . guard)
endfun

"close parenthesis/brackets and place cursor in between
inoremap ( ()<left>
inoremap [ []<left>
inoremap < <><left>
inoremap { {<cr>}<esc>ka<cr>
"TAB matches bracket pairs
vnoremap <tab> %
nnoremap <tab> %

"when jumping to a given line, center the screen
nnoremap G Gzz

"move around splits
noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l

"loose bad habits
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

"move by screenline
nnoremap j gj
nnoremap k gk

"remove search highlight
nnoremap <silent> <leader><space> :nohlsearch<cr>

"speed up scrolling
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

":cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" move lines up and down using ctrl+[jk]
nnoremap <C-k> mz:m-2<cr>`z
nnoremap <C-j> mz:m+<cr>`z
vnoremap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

" toggle whitespace visibility with <leader>s
nmap <leader>w :set list!<CR>
set listchars=tab:>\ ,trail:·,extends:»,precedes:«,nbsp:×

" disable Ex Mode
nnoremap Q <nop>

" ctrl-A select all
map	<C-a> ggVG

"-------------------------------------------------------------------------------
"								PLUGIN SPECIFIC
"-------------------------------------------------------------------------------

"	NERDTree

"toggle tree with ctrl-n
map <C-n> :NERDTreeToggle<CR>

"change current working directory
let NERDTreeChDirMode=2

"store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NTBookmarks")

"show bookmarks table on startup
let NERDTreeShowBookmarks=1

"show hidden files
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

"use a single click to fold/unfold directories and a double click to open files
let NERDTreeMouseMode=2

"don't display these kinds of files
let NERDTreeIgnore=[ '\.gch', '\.swp', '\.o$', '\.DS_Store']

"open on right side of window
let NERDTreeWinPos = "right"

"open a NERDTree if VIM starts up with no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"close VIM if only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"hides "Press ? for help"
let NERDTreeMinimalUI=1

"NERDTree Git symbols
let g:NERDTreeIndicatorMapCustom = {
            \ 'Modified'  : '✹',
            \ 'Staged'    : '✚',
            \ 'Untracked' : '✭',
            \ 'Renamed'   : '➜',
            \ 'Unmerged'  : '═',
            \ 'Deleted'   : '✖',
            \ 'Dirty'     : '✗',
            \ 'Clean'     : '✔︎',
            \ 'Unknown'   : '?'
			\ }

