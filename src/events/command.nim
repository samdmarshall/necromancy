# =======
# Imports
# =======

import "actions.nim"
import "constants.nim"

import "../logger.nim"

import "../models/types.nim"
import "../models/configuration.nim"

import "../ui/display.nim"

# =========
# Functions
# =========

proc perform*(screen: Window, settings: Configuration, command: string, args: seq[string]): bool = 
  Logger(Debug, "exec '" & command & "' with arguments: " & $args)
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
    screen.navigateIn(settings)
  of Command_GoOut:
    screen.navigateOut(settings)
  of Command_Prompt:
    discard
  of Command_Reload:
    draw(screen)
  else:
    discard
  return true
