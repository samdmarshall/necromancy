# =======
# Imports
# =======

import tables
import sequtils

import "termbox.nim"

# =====
# Types
# =====

type ColorTheme* = object
  executable: string
  directory: string

# =========
# Constants
# =========

const DefaultTheme* = ColorTheme(
  executable: "green",
  directory: "blue",
)

# =========
# Functions
# =========

iterator ColorThemeItems*(): string = 
  for name, value in DefaultTheme.fieldPairs():
    yield name

proc updateValue*(theme: var ColorTheme, key: string, value: string): void =
  case key
  of "executable":
    theme.executable = value
  of "directory":
    theme.directory = value
  else:
    discard
