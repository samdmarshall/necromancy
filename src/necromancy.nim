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
  configuration_path = os.expandTilde("~/.config/necromancy/config.cfg")
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

if not configuration_path.fileExists():
  echo("unable to find a configuration file at '" & configuration_path & "'! Please;")
  echo("  1. create it")
  echo("  -- or --")
  echo("  2. specify the path to the configuration file using:")
  echo("    * the command line flag `--config:path`")
  echo("    -- or --")
  echo("    * the environment variable `NECROMANCY_CONFIG`")
  quit(QuitFailure)

let configuration_full_path = os.expandFilename(configuration_path)
let configuration_directory = os.parentDir(configuration_full_path)

initiateLogger(configuration_directory, enable_trace_logging)

let user_configuration = loadUserConfiguration(configuration_full_path) 

# starting up the screen
startupDisplay()

var screen = createMainWindow()

if enable_trace_logging:
  var debug = createDebugView()
  screen.views.add(debug)

screen.reloadContents(configuration)
draw(screen)
while processInput(screen, user_configuration):
  draw(screen)

# shutting down the screen
shutdownDisplay()
