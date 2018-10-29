"
"===================================================================== PLUGINS
execute pathogen#infect()
call pathogen#helptags()
"......................................................................... ALE
let g:ale_emit_conflict_warnings = 0
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_list_window_size = 1
let g:ale_set_quickfix = 1
let g:airline#extensions#ale#enabled = 1
"================================================================= COLORSCHEME
if !has('gui_running')
    set t_Co=256                " max num of displayed colors on host terminal
endif
set background=dark
set t_ut=                       " disable background color erase
let base16colorspace=256
colorscheme base16-onedark
"================================================================== STATUSLINE
set laststatus=2                " show statusline 2 rows from bottom
set showcmd                     " show previous command in statusline
set showmode                    " show current mode in statusline
set statusline+=%#warningmsg#
set statusline+=%*
"===================================================================== OPTIONS
map <Space> <leader>
set tags=${HOME}/.vimtags
"......................................................... ENTER / EXIT / SAVE
au BufWinEnter * call GoToLastPos()
inoremap jk <ESC>|              " esc
inoremap jj <ESC>l|             " esc, keep cursor at current location
vnoremap jk <ESC>|              " esc
vnoremap jj <ESC>|              " esc
nnoremap <leader>w :w<CR>|      " save
nnoremap <leader>x :wq<CR>|     " save, exit
nnoremap <leader>q :q!<CR>|     " quit, no save
"................................................................... CLIPBOARD
set clipboard^=unnamed
vnoremap <silent><C-c> :call Copy()<CR>|
vnoremap <silent><C-v> :call Paste()<CR>|
vnoremap <silent><C-x> :call Cut()<CR>|
"............................................................... FILE HANDLING
set autoread                          " update file when changed outside vim
set noswapfile                        " turn off auto swp file creation
"--------------------------------------------------------------------- VISUALS
set colorcolumn=80                    " display column at 80 char mark
set cursorline                        " highlight/underline curr line
set list                              " display whitespace
set listchars=tab:\│\ |               " tabs as bars
set listchars+=trail:·|               " trailing whitespace as dots
syntax on, enable                     " syntax highlight on
nnoremap <leader>1 :call ToggleNumberline()<CR>|
au BufRead,BufNewFile *.md setlocal textwidth=79
au WinLeave * if &l:relativenumber | set relativenumber! | endif
" view header or source file
nnoremap <leader>h :vsp %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>|
"...................................................................... SEARCH
set hlsearch                         " highlight matches
set showmatch                        " highlight matching [{()}]
nnoremap <silent><Space><Space> :noh<CR>|      " turn off highlight
"..................................................................... WINDOWS
set splitright                       " open new window vertically split
nnoremap <leader>v :vsp %<CR>|       " vertical split current file
"....................................................................... BELLS
set noerrorbells                    " don't display error bells
set visualbell                      " display visual bells
"======================================================================= INPUT
set backspace=indent,eol,start      " enable backspace in Insert mode
set mouse=a                         " enable mouse support (click & highlight)
"........................................................................ CODE
set belloff+=ctrlg                  " if vim beeps during completion
set completeopt-=preview
set completeopt+=menuone
set completeopt+=longest
set completeopt+=noinsert
set completeopt+=noselect
set infercase                       " don't change case during completion
" select
inoremap <expr> <CR> pumvisible()? "\<C-y>" : "\<CR>"|
" iterate forward
inoremap <expr> <Tab> pumvisible()? "\<C-n>" : "\<Tab>"|
" iterate backward
inoremap <expr> <S-Tab> pumvisible()? "\<C-p>" : "\<S-Tab>"|
".................................................................... CMD MODE
set incsearch                   " case-insensitive incremental search
set wildmenu                    " visual autocomplete for command menu
set wildmode=list:longest,full  " autocomplete command menu with a list
"...................................................................... FORMAT
filetype plugin on              " detect filetype
filetype indent on              " load filetype-specific indent files
set autoindent                  " new line auto indents
set smarttab
set formatoptions+=c            " autowrap comments using `textwidth`
set formatoptions+=j            " del comment char when joining lines
set formatoptions+=n            " recognize numbered lists
set formatoptions+=v            " break at a blank
nnoremap <Tab> >>|              " indent right
nnoremap <leader><Tab> i<Tab><Esc>l| " <Tab> from cursor until eol
nnoremap <leader>8 gqq|         " make line match textwidth
nnoremap < V<|
nnoremap > V>|

augroup c_formatting
	autocmd!
	au FileType c set noexpandtab
	au FileType c set cindent
	au FileType c set shiftwidth=8
	au FileType c set softtabstop=0
	au FileType c set tabstop=8
	au FileType c set cinoptions=(0,u0,U0
augroup END

augroup markdown_formatting
	autocmd!
	au FileType markdown set shiftwidth=4
	au FileType markdown set softtabstop=0
	au FileType markdown set tabstop=4
	au FileType markdown set fo+=c
	au FileType markdown set fo-=r
	au FileType markdown set fo-=t
	au FileType markdown set comments+=b:>
	au FileType markdown set comments-=b:*
augroup END

augroup sh_formatting
	autocmd!
	au FileType sh set cindent
	au FileType sh set shiftwidth=4
	au FileType sh set softtabstop=0
	au FileType sh set tabstop=4
	au FileType sh set cinoptions=(0,u0,U0
augroup END

augroup vim_formatting
	autocmd!
	au FileType vim set fo-=r
	au FileType vim set shiftwidth=4
	au FileType vim set softtabstop=0
	au FileType vim set tabstop=4
augroup END
"=============================================================== ABBREVIATIONS
:ab #d #define
:ab #e #endif
:ab #f #ifdef
:ab #i #include
:ab ui6 uint64_t

augroup auto_fill_closing_char_c
	autocmd!
	au FileType c inoremap " ""<Left>|
	au FileType c inoremap [ []<Left>|
	au FileType c inoremap ( ()<Left>|
	au FileType c inoremap { {}<Left>|
	au FileType c inoremap {<CR> {<CR>}<Up>|
	au FileType c inoremap {;<CR> {<CR>};<Up>|
augroup END

augroup auto_fill_closing_char_sh
	au FileType sh inoremap " ""<Left>|
	au FileType sh inoremap ' ''<Left>|
	au FileType sh inoremap [ []<Left>|
	au FileType sh inoremap <silent>` ``<Left>|
	au FileType sh inoremap <silent>( ()|
	au FileType sh inoremap <silent>{<CR> {<CR>}<Esc>O|
	au FileType sh inoremap <silent>() ()<Space>{<CR>}<Esc>O|
	au FileType sh inoremap <silent>[[ [[<Space>]]<C-o>T <Space><Left>|
	au FileType sh inoremap <silent>$( $(<Space>)<C-o>T |
	au FileType sh inoremap <silent>${ ${}<Left>|
augroup END
"------------------------------------------------------------------ NAVIGATION
nnoremap <leader>[ []|         " go to start of func
nnoremap <leader>] ][|         " go to end of func
inoremap <C-e> <Esc>A|         " go to end of line
inoremap <C-a> <Esc>I|         " go to beginning of line
inoremap <C-k> <Esc>lDa|       " delete from cursor to end of line
inoremap <C-u> <CR><Esc>kddI|  " delete from cursor to start of line
"---------------------------------------------------------------------- VISUAL
nnoremap gp `[v`]|             " visual select newest pasted text

" vsp ctag def <A-e>
map ´ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>zt|
" map † :exec("tag ".expand("<cword>"))<CR>zt| 		" vsp ctag def <A-]>
"------------------------------------------------------------------- TEMPLATES
au FileType {c,python,sh} nnoremap <silent><leader>t :call TemplateCode()<CR>|
au FileType {c,python,sh} nnoremap <silent><leader>d :call DebugMsg()<CR>|
".................................................................... COMMENTS
au FileType {c,cpp,make,markdown,python,sh,text,tmux,vim}
	    \ nnoremap <silent><leader>c :call Comment()<CR>|
au FileType {c,cpp,make,markdown,python,sh,text,tmux,vim}
	    \ vnoremap <silent><leader>c :call Comment()<CR>|
au FileType {c,cpp,make,markdown,python,sh,text,tmux,vim}
	    \ nnoremap <silent><leader>u :call Uncomment()<CR>|
au FileType {c,cpp,make,markdown,python,sh,text,tmux,vim}
	    \ vnoremap <silent><leader>u :call Uncomment()<CR>|
"------------------------------------------------------------------------ EDIT
nnoremap <leader>s :call TrWhitespace()<CR>|
inoremap <C-d> <Esc>lD|                    " del all char to the right
nnoremap <CR> o<Esc>|                      " insert newline below
nnoremap <leader>' ciw""<Esc>hp|           " quote word
nnoremap <leader>" ciW""<Esc>hp|           " quote Word
nnoremap <leader>pe A<Space><Esc>$p|       " paste one space after end
inoremap <C-j> <Esc>Ji|                    " join lines
"=================================================================== FUNCTIONS

"**********
" HELPERS *
"**********

func! AddPrefix(symbol)
    exe 's/^/' . a:symbol . ' ' . '/g'
endfunc


func! AddSuffix(symbol)
    exe 's/$/' . ' ' . a:symbol . '/g'
endfunc


func! CommentC()
    silent! s/\/\*/\/ */
    silent! s/\*\//* \//
    call AddPrefix("\\/*")
    call AddSuffix("*\\/")
endfunc


func! FormatIndents()
    norm! =i{
endfunc


func! RemovePrefix(symbol)
	exe 's/^' . a:symbol . ' //e'
endfunc


func! RemoveSuffix(symbol)
    exe 's/ ' . a:symbol . '//1'
endfunc


func! UncommentC()
    call RemovePrefix("\\/\\*")
    call RemoveSuffix("\\*\\/")
    silent! s/\/ \*/\/*/ge
    silent! s/\* \//*\//ge
endfunc

"************
" INTERNALS *
"************

func! Comment()
	if &l:filetype == "c"
		call CommentC()
	elseif &l:filetype == "cpp"
		call CommentC()
	elseif &l:filetype == "make"
		call AddPrefix('#')
	elseif &l:filetype == "markdown"
		call AddPrefix('#')
	elseif &l:filetype == "python"
		call AddPrefix('#')
	elseif &l:filetype == "sh"
		call AddPrefix('#')
	elseif &l:filetype == "text"
		call AddPrefix('-')
	elseif &l:filetype == "tmux"
		call AddPrefix('#')
	elseif &l:filetype == "vim"
		call AddPrefix("\"")
	endif
endfunc


func! Copy()
	norm! gv"+y
endfunc


func! Cut()
	norm! gv"+ygvd
endfunc


func! Paste()
	norm! gv"+p
endfunc


func! GoToLastPos()
	norm! g'"
	norm! zz
endfunc


" off -> seq num -> hybrid relative num -> off
func! ToggleNumberline()
	if !&l:number && !&l:relativenumber
		set number!
	elseif &l:number && &l:relativenumber
		set number!
		set relativenumber!
	elseif &l:number && !&l:relativenumber
		set relativenumber!
	elseif !&l:number && &l:relativenumber
	endif
endfunc


func! TrWhitespace()
	norm! ma
	let _s=@/
	%s/\s\+$//e
	let @/=_s
	norm! `a
endfunc


func! Uncomment()
	if &l:filetype == "c"
		call UncommentC()
	elseif &l:filetype == "cpp"
		call UncommentC()
	elseif &l:filetype == "make"
		call RemovePrefix('#')
	elseif &l:filetype == "markdown"
		call RemovePrefix('#')
	elseif &l:filetype == "python"
		call RemovePrefix('#')
	elseif &l:filetype == "sh"
		call RemovePrefix('#')
	elseif &l:filetype == "text"
		call RemovePrefix('-')
	elseif &l:filetype == "tmux"
		call RemovePrefix('#')
	elseif &l:filetype == "vim"
		call RemovePrefix("\"")
	endif
endfunc


" Paste toggles by itself
let &t_SI .= "\<ESC>[?2004h"
let &t_EI .= "\<ESC>[?2004l"
inoremap <special> <expr> <ESC>[200~ XTermPasteBegin()|
func! XTermPasteBegin()
    set pastetoggle=<ESC>[201~
    set paste
    return ""
endfunc
