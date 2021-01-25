# =======
# Imports
# =======

import tables
import sequtils

import "actions.nim"
import "command.nim"
import "bindings.nim"
import "constants.nim"

import "../logger.nim"

import "../models/types.nim"
import "../models/configuration.nim"

import "../ui/view.nim"
import "../ui/textview.nim"

import termbox

# =========
# Functions
# =========

proc handleEvent*(config: Configuration): bool =
  var mapped_action = ""
  var event: tb_event
  var poll_result = poll_event(addr event)
  let bound_key = translate(event)
  case event.kind
  of TB_EVENT_MOUSE:
    echo "mouse event"
  of TB_EVENT_KEY:
    echo "keyboard event"
  of TB_EVENT_RESIZE:
    mapped_action = Command_Reload
  else:
    echo "unknown event"
  if bound_key.len > 0:
    var found_mapped_actions = newSeq[UserKeyBinding]()
    for item in config.keys:
      if item.key == bound_key:
        found_mapped_actions.add(item)
    if found_mapped_actions.len > 0:
      if found_mapped_actions.len > 1:
        Logger(Warn, "this key has more than one binding associated with it, the last one defined in the config file will be used")
      mapped_action = found_mapped_actions[^1].action
    if CommandMap.hasKey(mapped_action):
      let command_string: string = CommandMap[mapped_action]
      let command_args = newSeq[string]()
      return config.action(command_string, command_args)
    else:
      Logger(Warn, "unknown command!")
    return true

proc processInput*(screen: Window, config: Configuration): bool =
  var mapped_action = ""
  var event: tb_event
  discard poll_event(addr event)
  let bound_key = translate(event)
  case event.kind
  of TB_EVENT_MOUSE:
    discard
  of TB_EVENT_KEY:
    writeToDebugConsole(screen, bound_key)
  of TB_EVENT_RESIZE:
    mapped_action = Command_Reload
  else:
    discard
  if bound_key.len > 0:
    var found_mapped_actions = newSeq[UserKeyBinding]()
    for item in config.keys:
      if item.key == bound_key:
        found_mapped_actions.add(item)
    if found_mapped_actions.len > 0:
      if found_mapped_actions.len > 1:
        Logger(Warn, "this key has more than one binding associated with it, the last one defined in the config file will be used")
      mapped_action = found_mapped_actions[^1].action
  if CommandMap.hasKey(mapped_action):
    let command_string: string = CommandMap[mapped_action]
    let command_args = newSeq[string]()
    return screen.perform(config, command_string, command_args)
  else:
    Logger(Warn, "unknown command!")
  return true
