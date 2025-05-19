# vim_as_ide

Vim with LSP client plugin as IDE replacement    

Using Vim as IDE set us free from learning key shortcuts for every IDE
and gives us the possibility to work with any language in the same environment

## What we expect from IDE

- code completion
- syntax highlighting
- error detection and linting
- refactoring tools
- debugging tools
- code navigation and search
- code snippets/templates
- documentation and tooltips
- test integration
- build and deployment tools
- project management

## Prerequisites

Each version of YCM plugin is built with the latest vim version and specific python support in vim

- suppose last version of python3 installed
- define python config dir: `python3-config --configdir`
- suppose we have vim distributive
- go to it and execute
```
./configure --with-features=huge \
            --enable-multibyte \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.10/config-3.10-x86_64-linux-gnu \
            --prefix=/usr/local

```
- `make`
- vim will be built as `src/vim`

## What plugins we need in vim

- First some plugin manager, I use Vundle https://github.com/VundleVim/Vundle.vim
- YCM plugin https://github.com/ycm-core/YouCompleteMe

YCM will not work just after installation

- go to  `~/.vim/bundle/YouCompleteMe`
- execute `./install.py --java`

## Other useful plugins

- nerdtree plugin https://github.com/preservim/nerdtree
- Git integration https://github.com/tpope/vim-fugitive
- farconics/victionary   " Vict
- vimwiki/vimwiki        " Vimwiki
- vim-scripts/grep.vim   " Grep
- dense-analysis/ale     " ALE - code linter
- szw/vim-g              " Google
- weirongxu/plantuml-previewer.vim " PlantUML support
- voldikss/vim-translator " Dictionary


## What we have in vim after that

- code completion       - no keyboard shortcuts had to be pressed
- syntax highlighting
- organize imports      - YcmCompleter OrganizeImports
- formatting            - YcmCompleter OrganizeImports
- error detecting
- documentation and tooltips
- show type hierarchy
- go to super implementation
- all git commands after :Git

All supported YCM commands:

CallHierarchy
ExecuteCommand
FixIt
Format
GetDoc
GetType
GoTo
GoToCallees
GoToCallers
GoToDeclaration
GoToDefinition
GoToDocumentOutline
GoToImplementation
GoToReferences
GoToSymbol
GoToType
OrganizeImports
RefactorRename
ResolveCallHierarchyItem
ResolveTypeHierarchyItem
RestartServer
TypeHierarchy
WipeWorkspace


## Examples

Java example supplied

## Tested on

- Ubuntu 22.04.5 LTS with cscope installed
- vim 9.1.1360 
- openjdk version "21.0.2" 2024-01-16
- python 3.10.12
- Gradle 8.6

## TODO: debugging

```
# gradle build
# jdb -sourcepath src/main/java -classpath build/classes/java/main demo.package1.A
```

## Other
Help for some vim keys is supplied at `keys.txt`
