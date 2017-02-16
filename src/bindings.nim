# =======
# Imports
# =======

import tables
import logging

import "termbox.nim"

# =====
# Types
# =====

type UserKeyBinding* = object
  `bind`: string
  action: string

type InternalBinding = object
  keyName: string
  tbMap: int

# =========
# Constants
# =========

## Action names
const
  Action_Help = "help"
  Action_Up = "navigate-up"
  Action_Down = "navigate-down"
  Action_Left = "navigate-left"
  Action_Right = "navigate-right"

let Actions = @[Action_Help, Action_Up, Action_Down, Action_Left, Action_Right]

## Key names
const
  Key_F1 = "<F1>"
  Key_F2 = "<F2>"
  Key_F3 = "<F3>"
  Key_F4 = "<F4>"
  Key_F5 = "<F5>"

# =======
# Globals
# =======

var BindingMap: Table[string, string]

# =========
# Functions
# =========

proc initializeBindings*(userMap: seq[UserKeyBinding]): void = 
  for binding in userMap:
    if not (binding.action in Actions):
      logging.fatal("Unrecognized key '" & binding.action & "' in key map!")
