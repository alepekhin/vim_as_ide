# vim_as_ide

Vim with `Coc` and `cscope` plugins as IDE replacement    

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

## What plugins we need in vim

- First some plugin manager, I use Vundle https://github.com/VundleVim/Vundle.vim
- coc.nvim https://github.com/neoclide/coc.nvim
- cscope plugin https://www.vim.org/scripts/script.php?script_id=4082
- nerdtree plugin https://github.com/preservim/nerdtree
- Git integration https://github.com/tpope/vim-fugitive

Also cscoup itself should be installed in OS

## What we have in vim after that

- code completion, just print or ctrl-space
- syntax highlighting
- organize imports, command :CocCommand editor.action.organizeImport
- formatting, :CocCommand editor.action.formatDocument, vim = also can format
- error detecting, the errors are underlined, hover on - show error
- documentation and tooltips, use :List to get doc for List
- show type hierarchy, :CocCommand java.action.showTypeHierarchy
- go to super implementation, :CocCommand ...
- All git commands after :Git

## Examples

Java and Groovy examples supplied

## Tested on

- Ubuntu 22.04.5 LTS with cscope installed
- vim 9.1.810 
- openjdk version "21.0.2" 2024-01-16
- Gradle 8.6
- Groovy Version: 4.0.23 JVM: 1.8.0_442 Vendor: Private Build OS: Linux
- Grails Version: 3.3.16 on| JVM Version: 1.8.0_442

## cscope usage

Tutorial: https://cscope.sourceforge.net/cscope_vim_tutorial.html

```
 find . -name "*.groovy" > cscope.files
 cscope -b
 vim .
```
## TODO: debugging

```
# gradle build
# jdb -sourcepath src/main/java -classpath build/classes/java/main demo.package1.A
```

## Other
Help for some vim keys is supplied at `keys.txt`
