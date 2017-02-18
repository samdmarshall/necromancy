# necromancy

_necromancy_ is a quick and simple file system browser for the command line.


## usage

you can start-up necromancy in any directory and it will start working out of your current working directory, you can also specify a path as an argument on the command line which will allow you to start browsing at that location without changing your working directory.

```
necromancy [--verbose] [--debug] [--config:path] [-h|--help] [-v|--version] path
```

## installation

from source (you will need to install [nim](http://nim-lang.org/) first, as well as [termbox](https://github.com/nsf/termbox)):
```
nimble build
```

from homebrew (dependencies are handled for you):
```
brew tap samdmarshall/formulae
brew install samdmarshall/necromancy
```

## why?

i have tried a bunch of command line file browsers, the ones i have liked most are [fdclone](http://hp.vector.co.jp/authors/VA012337/soft/fd/) and [noice](http://git.2f30.org/noice/). fdclone is nice but a bit too difficult to configure and i don't use it often as a result; and noice is good but minimal and lacking in more powerful features. 

oh, you mean why did i pick the name "necromancy"? because it is a really cool name for a project and i wanted to use it.
