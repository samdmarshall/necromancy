# =======
# Imports
# =======

import os
import sets
import parseopt2

import "logger.nim"
import "settings/preferences.nim"

import "models/types.nim"

import "events/actions.nim"
import "events/eventhandler.nim"

import "ui/view.nim"
import "ui/display.nim"

# =========
# Functions
# =========

proc progName(): string =
  result = getAppFilename().extractFilename()

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
if existsEnv("NECROMANCY_CONFIG"):
  configuration_path = getEnv("NECROMANCY_CONFIG").expandTilde()
else:
  configuration_path = expandTilde("~/.config/necromancy/config.cfg")
var working_directory = getCurrentDir()
var enable_trace_logging = false

for kind, key, value in getopt():
  case kind
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h":
      usage()
    of "version", "v":
      versionInfo()
    of "config":
      configuration_path = expandTilde(value)
    of "trace":
      enable_trace_logging = true
    else:
      discard
  of cmdArgument:
    working_directory = expandTilde(key)
  else:
    discard

if not configuration_path.fileExists():
  echo("unable to find a configuration file at '" & configuration_path & "'! Please;")
  echo("  1. create it")
  echo("  -- or --")
  echo("  2. specify the path to the configuration file using:")
  echo("    * the command line flag `--config:path`")
  echo("    -- or --")
  echo("    * the environment variable `NECROMANCY_CONFIG`")
  quit(QuitFailure)

let configuration_full_path = configuration_path.expandFilename()
let configuration_directory = configuration_full_path.parentDir()

initiateLogger(configuration_directory, enable_trace_logging)

let user_configuration = loadUserConfiguration(configuration_full_path) 

# starting up the screen
startupDisplay()

var screen = createMainWindow()

if enable_trace_logging:
  var debug = createDebugView()
  screen.views.add(debug)

screen = screen.reloadContents(user_configuration, working_directory)
while screen.processInput(user_configuration):
  screen.draw()

# shutting down the screen
shutdownDisplay()
