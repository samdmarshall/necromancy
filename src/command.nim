# =======
# Imports
# =======

import "windows.nim"
import "constants.nim"

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
