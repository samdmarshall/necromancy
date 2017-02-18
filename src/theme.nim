# =======
# Imports
# =======

import tables
import sequtils
import strutils

import "termbox.nim"

# =====
# Types
# =====

type ColorTheme* = object
  file*: string
  executable*: string
  directory*: string
  symlink*: string

# =========
# Constants
# =========

const DefaultTheme* = ColorTheme(
  file: "default",
  executable: "green",
  directory: "blue",
  symlink: "magenta",
)

# =========
# Functions
# =========

iterator ColorThemeItems*(): string = 
  for name, _ in DefaultTheme.fieldPairs():
    yield name

proc updateValue*(theme: var ColorTheme, key: string, value: string): void =
  case key
  of "file":
    theme.file = value
  of "executable":
    theme.executable = value
  of "directory":
    theme.directory = value
  of "symlink":
    theme.symlink = value
  else:
    discard

proc convertColorToTermbox*(color: string): uint16 = 
  case strutils.toLowerAscii(color)
  of "black":
    return TB_BLACK
  of "red":
    return TB_RED
  of "green":
    return TB_GREEN
  of "blue":
    return TB_BLUE
  of "magenta":
    return TB_MAGENTA
  of "yellow":
    return TB_YELLOW
  of "cyan":
    return TB_CYAN
  of "white":
    return TB_WHITE
  else:
    return TB_DEFAULT
    
