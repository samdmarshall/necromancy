# =======
# Imports
# =======

import "view.nim"
import "types.nim"
import "display.nim"
import "constants.nim"

# =========
# Functions
# =========

proc perform*(screen: Window, command: string, args: seq[string]): bool = 
  case command
  of Command_Help:
    discard
  of Command_Quit:
    return false
  of Command_Suspend:
    suspendDisplay()
    discard
  of Command_Up:
    discard
  of Command_Down:
    discard
  of Command_GoIn:
    discard
  of Command_GoOut:
    discard
  of Command_Prompt:
    discard
  of Command_Reload:
    discard
  else:
    discard
  return true
