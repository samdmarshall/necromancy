# =======
# Imports
# =======

import "actions.nim"
import "constants.nim"

import "../models/types.nim"

import "../ui/display.nim"

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
  of Command_Up:
    screen.navigateUp()
  of Command_Down:
    screen.navigateDown()
  of Command_GoIn:
    screen.navigateIn()
  of Command_GoOut:
    screen.navigateOut()
  of Command_Prompt:
    discard
  of Command_Reload:
    draw(screen)
  else:
    discard
  return true
