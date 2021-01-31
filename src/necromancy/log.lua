
local log = require("ltui/base/log")
local path = require("path")
local struct = require("struct")

function log:outputfile()
  if self._LOGFILE == nil then
    self._LOGFILE = os.getenv("NECROMANCY_LOGFILE") or false
  end
  return self._LOGFILE
end

function log:set_outputfile(filepath)
  local has_environment_var = os.getenv("NECROMANCY_LOGFILE") ~= nil
  if path.exists(filepath) then
    self._LOGFILE = path.fullpath(filepath)
  end
end

function log:caller_info(stack)
  return debug.getinfo(stack+1)
end

function log:format_info(level, info)
  local source_file = info["short_src"] or info["source"]
  local line_num = info["currentline"]
  local func_name = info["func_name"]
  if path.isfullpath(source_file) == false then
    source_file = path.basename(source_file)
  end
  return string.upper(level).." ".."["..source_file..":"..line_num.."]"
end

function log:print(...)
  local info = {}
  local module_name = "log.lua"
  local stack = 0
  repeat
    stack = stack + 1
    info = debug.getinfo(stack)
    module_name = path.basename(info["short_src"])
  until(module_name ~= "log.lua")

  local file = self:file()
  if file then
    file:write(self:format_info("info", info).." "..string.format(...)..'\n')
  end
end

function log:custom_write(level, info, ...)
  local file = self:file()
  if file then
    file:write(self:format_info(level, info).." "..string.format(...)..'\n')
  end
end

-- Level Methods
function log:debug(...)
  local info = self:caller_info(2)
  self:custom_write("debug", info, ...)
end

function log:info(...)
  local info = self:caller_info(2)
  self:custom_write("info", info, ...)
end

function log:notice(...)
  local info = self:caller_info(2)
  self:custom_write("notice", info, ...)
end

function log:warn(...)
  local info = self:caller_info(2)
  self:custom_write("warn", info, ...)
end

function log:error(...)
  local info = self:caller_info(2)
  self:custom_write("error", info, ...)
end

function log:fatal(...)
  local info = self:caller_info(2)
  self:custom_write("fatal", info, ...)
end

return log
