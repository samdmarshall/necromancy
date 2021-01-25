==========
necromancy
==========

*necromancy* is a quick and simple file system browser for the command line.


Usage
-----

you can start-up necromancy in any directory and it will start working out of your current working directory, you can also specify a path as an argument on the command line which will allow you to start browsing at that location without changing your working directory.


::

  necromancy [--verbose] [--debug] [--config:path] [-h|--help] [-v|--version] path



Installation
------------

Requirements:

1. `Nim <https://nim-lang.org>`_ language runtime
2. `Termbox <https://github.com/nsf/termbox>`_ library

::

  $ nimble build
  $ nimble install
