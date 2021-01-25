# =======
# Imports
# =======

import tables

# =========
# Constants
# =========

const
  Command_Help* = "help"
  Command_Quit* = "quit"
  Command_Suspend* = "suspend"
  Command_Up* = "up"
  Command_Down* = "down"
  Command_GoIn* = "in"
  Command_GoOut* = "out"
  Command_Prompt* = "prompt"
  Command_Reload* = "reload"


const
  Action_Help* = "help"
  Action_Suspend* = "suspend"
  Action_Quit* = "quit"
  Action_Up* = "navigate-up"
  Action_Down* = "navigate-down"
  Action_Left* = "navigate-left"
  Action_Right* = "navigate-right"
  Action_CommandPrompt* = "command-prompt"
  # Action_CommandPin = "pin-tab"
  # Action_CommandPop = "pop-tab"
  # Action_NextTab = "next-tab"
  # Action_PrevTab = "prev-tab"

const CommandMap*: Table[string, string] = @{
  Action_Help: Command_Help,
  Action_Suspend: Command_Suspend,
  Action_Quit: Command_Quit,
  Action_Up: Command_Up,
  Action_Down: Command_Down,
  Action_Left: Command_GoOut,
  Action_Right: Command_GoIn,
  Action_CommandPrompt: Command_Prompt,
}.toTable

const
  ViewName_Main* = "main-screen"
  ViewName_TopBar* = "top-bar"
  ViewName_DirectoryPath* = "directory-path"
  ViewName_DirectoryContents* = "directory-contents"
  ViewName_ItemSelector* = "file-selector"
  ViewName_BottomBar* = "bottom-bar"
  ViewName_CommandEntry* = "command-prompt"
  ViewName_DebugConsole* = "debug-console"
