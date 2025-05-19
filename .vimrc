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
" filetype off     " required, don't remove

" set the runtime path to include Vundle plugin manager and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'   " Plug
Plugin 'preservim/nerdtree'
Plugin 'natebosch/vim-lsc' 
Plugin 'farconics/victionary'   " Vict
Plugin 'vimwiki/vimwiki'        " Vimwiki
Plugin 'vim-scripts/grep.vim'   " Grep
Plugin 'dense-analysis/ale'     " ALE - code linter
Plugin 'szw/vim-g'              " Google
Plugin 'weirongxu/plantuml-previewer.vim'
Plugin 'voldikss/vim-translator' " Dictionary
Plugin 'tpope/vim-fugitive'     " Git support 
" dependencies for java format plugin
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
call vundle#end()               " required

" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /home/alepekhin/bin/google-java-format-1.27.0-all-deps.jar --aosp"


filetype plugin indent on       " required

" victionary
let g:victionary#format_results = 0
nmap \t <Plug>(victionary#define_under_cursor)20<C-w>+

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
let g:translator_source_lang="en"
let g:translator_target_lang="ru"
nmap <silent> \e <Plug>TranslateW

command -nargs=1 OpenJavaFile tabedit `find . -name <args>.java`
let g:lsc_server_commands = {'java': '/home/alepekhin/Github/java-language-server/dist/lang_server_linux.sh'}
" let g:lsc_server_commands = {'java': '/home/alepekhin/Github/java-language-server/dist/debug_adapter_linux.sh'}



