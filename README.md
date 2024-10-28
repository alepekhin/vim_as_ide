# vim_as_ide
Vim IDE based on YouCompleteMe and cscope

## Prerequisites

- Ubuntu 22.04.5 LTS with cscope installed
- vim 9.1.810 with ycm and cscope plugins installed
- openjdk version "21.0.2" 2024-01-16
- Gradle 8.6
- Groovy installed
- Groovy language server installed

## Usage

- copy .vim and .vimrc to home directory
- go to project directory
- execute
```
 find . -name "*.java" > cscope.files
 cscope -b
 vim .
```
## Features
- show code completion - `Ctrl-space`
- show class and methods docs - keep cursor on name
- find word, definition or open file 
```
yank word and then
Ctrl-\ s|g|f - s=search, g=global, f=file
or
:sc find s|g|f word
```
- do refactoring - `:YcmCompleter RefactorName new_name`
- improve code `:YcmCompleter FixIt`
- format code `:YcmCompleter Format`
- debugging

```
# gradle build
# jdb -sourcepath src/main/java -classpath build/classes/java/main demo.package1.A
```
## Other
Help for some vim keys is supplied at `keys.txt`
