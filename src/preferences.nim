# =======
# Imports
# =======

import os
import yaml
import streams

import "types.nim"
import "logger.nim"

# =========
# Functions
# =========

proc loadPreferences*(path: string): Configuration = 
  Logger(Debug, "Loading preference data...")
  var config: Configuration
  if os.fileExists(path):
    let config_file_descriptor = streams.newFileStream(path)
    yaml.serialization.load(config_file_descriptor, config)
    config_file_descriptor.close()
  else:
    Logger(Fatal, "Unable to load preference data, aborting!")
  result = config
