# vim_as_ide
Vim IDE based on YouCompleteMe and cscope

## Prerequisites

- Ubuntu 22.04.5 LTS with cscope installed
- vim 9.1.810 with all needed plugins installed and .vimrc from this project
- openjdk version "21.0.2" 2024-01-16
- Gradle 8.6

## Usage

- code completion - Ctrl-space
- class and methods docs - keep cursor on name
- refactoring - :YcmCompleter RefactorName new_name
- creating cscope.out:
```
# find . -name "*.java" > cscope.files
# cscope -b

then see usage at class A
```
- debugging
```
# gradle build
# jdb -sourcepath src/main/java -classpath build/classes/java/main demo.package1.A
```

