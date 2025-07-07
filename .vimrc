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
Plugin 'VundleVim/Vundle.vim'   " Plug
Plugin 'preservim/nerdtree'
Plugin 'alepekhin/vim-lsc' 
Plugin 'farconics/victionary'   " Vict
Plugin 'vimwiki/vimwiki'        " Vimwiki
Plugin 'vim-scripts/grep.vim'   " Grep
Plugin 'szw/vim-g'              " Google
Plugin 'weirongxu/plantuml-previewer.vim'
Plugin 'voldikss/vim-translator' " Dictionary
Plugin 'tpope/vim-fugitive'     " Git support 
Plugin 'othree/xml.vim'         " xml editing
Plugin 'vim/colorschemes'
Plugin 'gergap/vim-ollama'
call vundle#end()               " required
" 
" victionary 
let g:victionary#format_results = 0
" explain word 
nnoremap \e <Plug>(victionary#define_under_cursor)20<C-w>+
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
" Translater settings 
let g:translator_source_lang="en"
let g:translator_target_lang="ru"
" translate word
nnoremap <silent> \t <Plug>TranslateW
" 
" Lnaguage server related settings 
command -nargs=1 OpenJavaFile tabedit `find . -name <args>.java`
let g:lsc_server_commands = {'java': '/home/alepekhin/Github/java-language-server/dist/lang_server_linux.sh'}
"let g:lsc_server_commands = {'java': '/home/alepekhin/Github/branches/java-language-server-main/dist/lang_server_linux.sh'}
nnoremap K :LSClientShowHover<CR>
command FindUsages LSClientFindReferences
command FindDefinition LSClientGoToDefinitionSplit
set completeopt-=preview
" highlight code 
:syntax on
:filetype plugin on
" :colorscheme blue
" :colorscheme elflord
:colorscheme torte
:setlocal omnifunc=syntaxcomplete#Complete
:set backspace=indent,eol,start
"" set sensible highlight matches that don't obscure the text 
:highlight MatchParen cterm=underline ctermbg=black ctermfg=NONE
:highlight MatchParen gui=underline guibg=black guifg=NONE
:highlight Error ctermbg=magenta ctermfg=black
"
:iabbrev ppp System.out.println();

command Keys new +set\ noma|set\ ro ~/vimwiki/Vim.wiki
" autocmd FileType html setlocal formatprg=tidy\ -indent\ -quiet\ --show-errors\ 0\ --tidy-mark\ no\ --show-body-only\ auto
" Define a command to fetch URL and show response
command! -nargs=0  Joke call JokeResponse()

function! JokeResponse()
  " Run curl command, capture output
  let l:response = system('curl -s ' . shellescape("https://v2.jokeapi.dev/joke/any"))
  
  " Open a new split window
  new
  " Set buffer content to response
  call setline(1, split(l:response, "\n"))
  " Optional: set buffer name
  file Curl Response
  " Optional: set buffer to read-only
  setlocal buftype=nofile bufhidden=wipe nobuflisted
endfunction
