# =======
# Imports
# =======

import "view.nim"

# =========
# Constants
# =========

const 
  Command_Help* = "help"
  Command_Quit* = "quit"
  Command_Suspend* = "suspend"
  Command_GoIn* = "in"
  Command_GoOut* = "out"
  Command_List* = "list"
  Command_Touch* = "touch"
  Command_Make* = "make"
  Command_Remove* = "remove"
  Command_Move* = "move"
  Command_Copy* = "copy"
  Command_Find* = "find"

# =========
# Functions
# =========

proc processCommand*(command: string, args: seq[string]): bool =
  case command
  of Command_Help:
    discard
  of Command_Quit:
    view.shutdownDisplay()
    return false
  of Command_Suspend:
    view.suspendDisplay()
  of Command_GoIn:
    discard
  of Command_GoOut:
    discard
  of Command_List:
    discard
  of Command_Touch:
    discard
  of Command_Make:
    discard
  of Command_Remove:
    discard
  of Command_Move:
    discard
  of Command_Copy:
    discard
  of Command_Find:
    discard
  else:
    return false
  return true
