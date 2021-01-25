# =======
# Imports
# =======

import os
import logging
import strutils

# =====
# Types
# =====

type LogCode* = enum
    Notice,
    Info,
    Debug,
    Warn,
    Error,
    Fatal

# =========
# Templates
# =========

template Logger*(code: LogCode, formatString: string): void =
  let pos = instantiationInfo()
  let log_string = "[$1:$2] $3" % [pos.filename, $pos.line, formatString]
  case code
  of LogCode.Notice:
    notice(log_string)
  of LogCode.Info:
    info(log_string)
  of LogCode.Debug:
    debug(log_string)
  of LogCode.Warn:
    warn(log_string)
  of LogCode.Error:
    error(log_string)
  of LogCode.Fatal:
    fatal(log_string)
    quit(QuitFailure)

# =========
# Functions
# =========

proc initiateLogger*(log_dir: string, enableTrace: bool): void =
  var logging_level = Level.lvlWarn
  if enableTrace:
    logging_level = Level.lvlDebug
  if existsOrCreateDir(log_dir):
    let log_file_path = log_dir.joinPath("trace.log")
    let application_logger = newRollingFileLogger(log_file_path)
    addHandler(application_logger)
