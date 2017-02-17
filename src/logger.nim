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
    logging.notice(log_string)
  of LogCode.Info:
    logging.info(log_string)
  of LogCode.Debug:
    logging.debug(log_string)
  of LogCode.Warn:
    logging.warn(log_string)
  of LogCode.Error:
    logging.error(log_string)
  of LogCode.Fatal:
    logging.fatal(log_string)
    quit(QuitFailure)

# =========
# Functions
# =========

proc initiateLogger*(log_dir: string, enableTrace: bool): void = 
  var logging_level = Level.lvlWarn
  if enableTrace:
    logging_level = Level.lvlDebug
  if os.existsOrCreateDir(log_dir):
    let log_file_path = os.joinPath(log_dir, "trace.log")
    let application_logger = logging.newRollingFileLogger(fileName = log_file_path, levelThreshold = logging_level, fmtStr = "[$levelname] ")
    logging.addHandler(application_logger)
