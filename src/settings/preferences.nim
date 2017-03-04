# =======
# Imports
# =======

import os
import tables
import parsecfg
import sequtils
import strutils

import "../logger.nim"

import "../models/types.nim"

import "../events/bindings.nim"
import "../events/constants.nim"

# =========
# Functions
# =========

proc interpretAsBoolean(value :string): bool =
  if value.toLowerAscii() in @["true", "yes", "1"]:
    return true
  if value.toLowerAscii() in @["false", "no", "0"]:
    return false
  else:
    raise newException(OSError, "invalid boolean value parsed in config file!")
    

proc loadUserConfiguration*(path: string): Configuration = 
  Logger(Debug, "Loading preference data...")
  if not os.fileExists(path):
    Logger(Fatal, "Unable to load preference data, aborting!")
  let config_data: Config = loadConfig(path)
  
  var bindings = newSeq[UserKeyBinding]()
  for action_mapping in CommandMap.keys():
    let mapping: string = config_data.getSectionValue("keys", action_mapping)
    bindings.add(UserKeyBinding(key: mapping, action: action_mapping))
    Logger(Info, "Mapping '" & mapping & "' to '" & action_mapping & "'")
  
  let mouse_value = config_data.getSectionValue("general", "mouse")
  if mouse_value.interpretAsBoolean():
    bindings.add(UserKeyBinding(key: "<scroll-up>", action: Action_Up))
    bindings.add(UserKeyBinding(key: "<scroll-down>", action: Action_Down))

  let color_scheme_file_name = config_data.getSectionValue("color", "theme")
  let themes_directory = path.parentDir().joinPath("themes")
  let theme_file_path = themes_directory.joinPath(color_scheme_file_name)
  let color_config: Config = loadConfig(theme_file_path)
  

  var config = Configuration(keys: bindings)

  result = config
