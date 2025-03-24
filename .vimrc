" Start NERDTree when Vim starts with a directory argument.
let g:NERDTreeHijackNetrw = 1
" autocmd VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |  execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif

" cursor changes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" timeout of cursor changes
set ttimeout
set ttimeoutlen=1
set ttyfast

" set sensible highlight matches that don't obscure the text
:highlight MatchParen cterm=underline ctermbg=black ctermfg=NONE
:highlight MatchParen gui=underline guibg=black guifg=NONE

" highlight code
:syntax on
:filetype plugin on
:setlocal omnifunc=syntaxcomplete#Complete

:set backspace=indent,eol,start
set nocompatible " required, don't remove
filetype off     " required, don't remove

" set the runtime path to include Vundle plugin manager and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'neoclide/coc.nvim'
" Plugin 'neoclide/coc-java'
call vundle#end()            " required
filetype plugin indent on    " required

" coc plugin setting
hi CocFloating ctermbg=black
hi CocMenuSel ctermbg=darkgrey ctermfg=white
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-@> coc#refresh()
" Use :CocCommand java.project.addToSourcePath.command to add custom folder to Java Source Path

" cscope
source ~/.vim/cscope.vim

set signcolumn=no

" show status line with cursor position
set laststatus=2
set ruler

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab


" don't show preview scratch wibdow
"set completeopt-=preview

" Return to netrw view
map <silent> <C-\><C-\> <C-w>w
