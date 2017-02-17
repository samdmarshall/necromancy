import logging
import strutils

type LogCode* = enum
    Info,
    Debug,
    Warn,
    Error,
    Fatal

template Logger*(code: LogCode, formatString: string): void =
  let pos = instantiationInfo()
  let log_string = "[$1:$2] $3" % [pos.filename, $pos.line, formatString]
  case code
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

proc initiateLogger*(useVerbose: bool, useDebug: bool): void = 
  var logging_level = Level.lvlWarn
  if useVerbose:
    logging_level = Level.lvlInfo
  if useDebug:
    logging_level = Level.lvlDebug
  let application_logger = logging.newConsoleLogger(logging_level, "[$levelname] ")
  logging.addHandler(application_logger)
