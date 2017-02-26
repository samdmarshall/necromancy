# =======
# Imports
# =======

import os
import tables
import parsecfg
import sequtils

import "types.nim"
import "logger.nim"
import "actions.nim"
import "bindings.nim"
import "constants.nim"


# =========
# Functions
# =========

proc loadUserConfiguration*(path: string): Configuration = 
  Logger(Debug, "Loading preference data...")
  if not os.fileExists(path):
    Logger(Fatal, "Unable to load preference data, aborting!")
  let config_data: Config = parsecfg.loadConfig(path)
  
  var bindings = newSeq[UserKeyBinding]()
  for action_mapping in CommandMap.keys():
    let mapping: string = parsecfg.getSectionValue(config_data, "keys", action_mapping)
    bindings.add(UserKeyBinding(key: mapping, action: action_mapping))
    Logger(Info, "Mapping '" & mapping & "' to '" & action_mapping & "'")
  bindings.add(UserKeyBinding(key: "<scroll-up>", action: Action_Up))
  bindings.add(UserKeyBinding(key: "<scroll-down>", action: Action_Down))

  var config = Configuration(keys: bindings)

  result = config
