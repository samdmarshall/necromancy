# =========
# Constants
# =========

const 
  Command_Help = "help"
  Command_Quit = "quit"
  Command_Suspend = "suspend"
  Command_GoIn = "in"
  Command_GoOut = "out"
  Command_Relist = "relist"
  Command_Touch = "touch"
  Command_Make = "make"
  Command_Remove = "remove"
  Command_Move = "move"
  Command_Copy = "copy"
  Command_Find = "find"

# =========
# Functions
# =========

proc processCommand*(command: string): void =
  case command
  of Command_Help:
    discard
  of Command_Quit:
    discard
  of Command_Suspend:
    discard
  of Command_GoIn:
    discard
  of Command_GoOut:
    discard
  of Command_Relist:
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
    discard
