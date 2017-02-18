# =======
# Imports
# =======

import os
import sets
import parseopt2

import "logger.nim"
import "command.nim"
import "windows.nim"
import "preferences.nim"
import "eventhandler.nim"

# =========
# Functions
# =========

proc progName(): string =
  result = os.extractFilename(os.getAppFilename())

proc usage(): void = 
  echo("usage: " & progName() & " [-v|--version] [-h|--help] [--config:path] [--trace] [directory path]")
  quit(QuitSuccess)

proc versionInfo(): void =
  echo(progname() & " v0.1")
  quit(QuitSuccess)

# ===========================================
# this is the entry-point, there is no main()
# ===========================================

var configuration_path: string
if os.existsEnv("NECROMANCY_CONFIG"):
  configuration_path = os.expandTilde(os.getEnv("NECROMANCY_CONFIG"))
else:
  configuration_path = os.expandTilde("~/.config/necromancy/config.yml")
var working_directory = os.getCurrentDir()
var enable_trace_logging = false

for kind, key, value in parseopt2.getopt():
  case kind
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h":
      usage()
    of "version", "v":
      versionInfo()
    of "config":
      configuration_path = os.expandTilde(value)
    of "trace":
      enable_trace_logging = true
    else:
      discard
  of cmdArgument:
    working_directory = os.expandTilde(key)
  else:
    discard

let configuration_full_path = os.expandFilename(configuration_path)
let configuration_directory = os.parentDir(configuration_full_path)

initiateLogger(configuration_directory, enable_trace_logging)

let config = preferences.load(configuration_full_path)

var window = windows.createWindow(config.colorMode, working_directory)
windows.initializeDisplay(window)
while eventhandler.processInput(window, config.keys):
  windows.redraw(window)
