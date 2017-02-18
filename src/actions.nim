# =======
# Imports
# =======

import "cmd.nim"
import "view.nim"
import "logger.nim"

# =========
# Constants
# =========

## Action names
const
  Action_Help = "help"
  Action_Suspend = "suspend"
  Action_Quit = "quit"
  Action_Up = "navigate-up"
  Action_Down = "navigate-down"
  Action_Left = "navigate-left"
  Action_Right = "navigate-right"
  Action_CommandPrompt = "command-prompt"
  Action_CommandPin = "pin-tab"
  Action_CommandPop = "pop-tab"
  Action_NextTab = "next-tab"
  Action_PrevTab = "prev-tab"

let KnownActions* = @[
  Action_Help,
  Action_Suspend,
  Action_Quit,
  Action_Up,
  Action_Down,
  Action_Left,
  Action_Right,
  Action_CommandPrompt,
  Action_CommandPin,
  Action_CommandPop,
  Action_NextTab,
  Action_PrevTab,
]

# =================
# Private Functions
# =================


# ================
# Public Functions
# ================

proc handleAction*(action: string): bool =
  case action
  of Action_Help:
    discard
  of Action_Suspend:
    return processCommand(Command_Suspend, @[])
  of Action_Quit:
    return processCommand(Command_Quit, @[])
  of Action_Up:
    discard
  of Action_Down:
    discard
  of Action_Left:
    discard
  of Action_Right:
    discard
  of Action_CommandPrompt:
    discard
  else:
    Logger(Error, "Unknown action '" & action & "'!")
  return true
