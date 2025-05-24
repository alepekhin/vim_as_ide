# vim_as_ide

Vim with LSP client plugin as IDE replacement    

Using Vim as IDE set us free from learning key shortcuts for every IDE
and gives us the possibility to work with any language in the same environment

## What we expect from IDE

- code completion
- syntax highlighting
- error detection and linting
- code formatting
- refactoring tools
- debugging tools
- code navigation and search
- code snippets/templates
- documentation and tooltips
- test integration
- build and deployment tools
- project management

## Prerequisites

### Some applications in operating system

- Java language server [https://github.com/georgewfraser/java-language-server](https://github.com/georgewfraser/java-language-server)
- Java code formatter [https://github.com/google/google-java-format](https://github.com/google/google-java-format)

### Some plugins should be installed in vim

- VundleVim/Vundle.vim  - plugin manager [https://github.com/VundleVim/Vundle.vim](https://github.com/VundleVim/Vundle.vim)
- natebosch/vim-lsc     - language server client plugin [https://github.com/natebosch/vim-lsc](https://github.com/natebosch/vim-lsc)
- preservim/nerdtre     - file manager plugin [https://github.com/preservim/nerdtree](https://github.com/preservim/nerdtree)
- vim-scripts/grep.vim  - Grep plugin [https://github.com/vim-scripts/grep.vim](https://github.com/vim-scripts/grep.vim)

## Other useful plugins

- tpope/vim-fugitive    - Git integration [https://github.com/tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
- farconics/victionary  - a dictionary plugin [https://github.com/farconics/victionary](https://github.com/farconics/victionary)
- vimwiki/vimwiki       - vimwiki [https://github.com/vimwiki/vimwiki](https://github.com/vimwiki/vimwiki)
- dense-analysis/ale    - code linter [https://github.com/dense-analysis/ale](https://github.com/dense-analysis/ale)
- szw/vim-g             - Google [https://github.com/szw/vim-g](https://github.com/szw/vim-g)
- weirongxu/plantuml-previewer.vim  - PlantUML support [https://github.com/weirongxu/plantuml-previewer.vim](https://github.com/weirongxu/plantuml-previewer.vim)
- voldikss/vim-translator           - EN-RU translator [https://github.com/voldikss/vim-translator](https://github.com/voldikss/vim-translator)


## What we have in vim after that
 
- code completion
    print 3 letters and wait
- syntax highlighting
    yes
- error detection and linting
    yes
- code formatting
    :FormatCode
- refactoring tools
    :LSClientRename - does not work properly
- debugging tools
    none
- code navigation and search
    :LSClientGoToDefinition
    :LSClientGoToDefinitionSplit
    :LSClientFindImplementations - does not work at all
    :LSClientFindReferences - fiend where this variable used
    :Grep -IR
- code snippets/templates
    none
- documentation and tooltips
    :LSClientShowHover
    :Google topic ie "java list api"
- test integration
    none
- build and deployment tools
    use OS commands
- project management
    support for maven and gradle projects
    support git through :Git
    show file maneger through nerdtree plugin

## Examples

Java example supplied

## Tested on

- Ubuntu 22.04.5 LTS with cscope installed
- vim 9.1.1360 
- openjdk version "21.0.2" 2024-01-16
- python 3.10.12
- Gradle 8.6

## Debugging

For debugging we need to know jdb and it's commands

[See jdb documentation](https://docs.oracle.com/javase/7/docs/technotes/tools/windows/jdb.html)

Example:

```
# gradle build
# jdb -sourcepath src/main/java -classpath build/classes/java/main demo.package.Applicaton
```

