# =======
# Imports
# =======

import "windows.nim"

# =======
# Globals
# =======

const
  Command_Help* = "help"
  Command_Quit* = "quit"
  Command_Suspend* = "suspend"

const CommandsList*: seq[string] = @[
  Command_Help,
  Command_Quit,
  Command_Suspend,
]

# =========
# Functions
# =========

proc perform*(window: Window, command: string, args: seq[string]): bool = 
  case command
  of Command_Help:
    discard
  of Command_Quit:
    windows.shutdownDisplay(window)
    return false
  of Command_Suspend:
    windows.suspendDisplay(window)
  else:
    discard
  return true
