" Start NERDTree when Vim starts with a directory argument
let g:NERDTreeHijackNetrw = 1
" autocmd VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |  execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif
"
" cursor changes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" 
" timeout of cursor changes
set ttimeout
set ttimeoutlen=1
set ttyfast
" 
" mouse support in popup window 
set mouse=a
" 
" set the runtime path to include Vundle plugin manager and initialize {{{
set rtp+=~/.vim/bundle/Vundle.vim
" 
" plugin section 
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'   " Plugin manaGger
Plugin 'preservim/nerdtree'     " File manager
Plugin 'vimwiki/vimwiki'        " Vimwiki
Plugin 'natebosch/vim-lsc'      " language server client 
Plugin 'vim-autoformat/vim-autoformat'
Plugin 'gergap/vim-ollama'      " LLM support
call vundle#end()               " required
" 
let g:ollama_use_inline_diff=0
let g:ollama_enabled=1
" 
" show status line with cursor position 
set laststatus=2
set ruler
" 
" Formatting settings, required
set signcolumn=no
filetype plugin indent on
set nocompatible
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" 
" Lnaguage server related settings 
command -nargs=1 OpenJavaFile tabedit `find . -name <args>.java`
let g:lsc_server_commands = {'java': '/home/alepekhin/Github/java-language-server/dist/lang_server_linux.sh'}
"let g:lsc_server_commands = {'java': '/home/alepekhin/Github/branches/java-language-server-main/dist/lang_server_linux.sh'}
set completeopt-=preview
" highlight code 
:syntax on
:filetype plugin on
"" set sensible highlight matches that don't obscure the text 
:highlight MatchParen cterm=underline ctermbg=black ctermfg=NONE
:highlight MatchParen gui=underline guibg=black guifg=NONE
:highlight Error ctermbg=magenta ctermfg=black
"
:iabbrev sop System.out.println();
:iabbrev psv public static void main(String[] args){}
" Use ctrl-c Ctrl-v to copy/past
vnoremap <C-c> "+y
nmap <C-v> "+p
imap <C-v> <esc>"+pi
"
let g:formatterpath = ['/home/alepekgin/bin/java-beautify']
