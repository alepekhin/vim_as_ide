# vim_as_ide
Vim IDE based on YouCompleteMe, cscope, lsp

## Prerequisites

- Ubuntu 22.04.5 LTS with cscope installed
- vim 9.1.810 with all needed plugins installed and .vimrc from this project
- openjdk version "21.0.2" 2024-01-16
- Gradle 8.6
- Groovy installed
- Groovy language server installed

## Usage

- go to project directory
- execute
```
 find . -name "*.java" > cscope.files
 cscope -b
 vim .
```
## Features of YouCompleteMe
- code completion - `Ctrl-space`
- class and methods docs - keep cursor on name
- find definition 
```
yank word and then
Ctrl-\ s|g|f - s=search, g=global, f=file
or
:sc find s|g|f word
```
- refactoring - `:YcmCompleter RefactorName new_name`
- improve code `:YcmCompleter FixIt`
- format code `:YcmCompleter Format`
- debugging

```
# gradle build
# jdb -sourcepath src/main/java -classpath build/classes/java/main demo.package1.A
```
## Features of lsp for groovy code
- not investigated
