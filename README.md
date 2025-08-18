# vim_as_ide

Vim with LSP and LLM client plugins as IDE replacement    

Using Vim as IDE set us free from learning key shortcuts for every IDE
and gives us the possibility to work with any language in the same environment

Example of `.vimrc` supplied

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
- create and review code with AI

## Prerequisites

### Some applications in operating system

- Java language server [https://github.com/georgewfraser/java-language-server](https://github.com/georgewfraser/java-language-server)
- ollama and language model https://ollama.com/

### Some plugins should be installed in vim

See example in .vimtc

## What we have in vim after that

From vim-lsc plugin https://github.com/natebosch/vim-lsc

- code completion
    print 3 letters and wait
- syntax highlighting
    yes
- error detection
    :LSClientAllDiagnostics 
- linting
    ???
- code formatting
    :Autoformat
- refactoring tools
    :LSClientRename - can rename variable at least
- test integration
- debugging tools
    :terminal       - open terminal and use jdb
- code navigation and search
    :LSClientGoToDefinition         - open in the same windiw
    :LSClientGoToDefinitionSplit    - open in split window
    :LSClientFindImplementations    - does not work in our language server
    :LSClientFindReferences         - works
    use grep if nothing helps
- code snippets
    none
- documentation and tooltips
    :LSClientShowHover  - use mouse scroll button or touchpad two fingers for scrolling in popup
- build and deployment tools
    :terminal                       - open terminal and use OS commands
- project management
    support for maven and gradle projects
    show file maneger through nerdtree plugin
- ollama LLM client with code generation and review
  yank prompt and execute
  :.OllamaEdit do                   - insert AI generated code at current line (.)

## Examples

Java examples supplied.
See ollama usage in MyFictionBook.java

## Tested on

- Ubuntu 22.04.5 LTS with cscope installed
- vim 9.1.1360 
- openjdk version "21.0.2" 2024-01-16
- python 3.10.12
- Gradle 8.6

## Debugging

For debugging we need to know jdb and it's commands

[See jdb documentation](https://docs.oracle.com/javase/7/docs/technotes/tools/windows/jdb.html)

For debug unit test in typical gradle project:
```
gradle clean test --debug-jvm
jdb -attach 5005
help
use src/main/java
stop at Solution:10
run
list
step                      -- execute current line
step up                   -- execute until the current method returns to its caller
stepi                     -- execute current instruction
next                      -- step one line (step OVER calls)
cont                      -- continue execution from breakpoint
exit
```
