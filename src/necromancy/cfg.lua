
local ltui = require("ltui")
local path = require("path")
local ini = require("necromancy.vendor.ini")

local log = require("necromancy.log")
local utilities = require("necromancy.utilities")

local cfg = cfg or ltui.object() -- luacheck: globals cfg

function cfg:new(filepath)
  self = self()
  self:init(filepath)
  return self
end

function cfg:init(filepath)
  self._path = path.fullpath(filepath)
  if path.exists(self._path) then
    self._data = ini.parse_file(self._path)
  else
    log:error("failed to load ini file!")
  end
end

function cfg:data()
  return self._data
end

function cfg:path()
  return self._path
end

function cfg:dump()
  for k,v in pairs(self._data) do
    print(tostring(k))
    for sk,sv in pairs(v) do
      print("  "..tostring(sk),tostring(sv))
    end
  end
end

function cfg:get_default(default, ...)
  local result = self:get(...)
  if result == nil then
    result = default
  end
  return result
end

function cfg:get(...)
  local result = self._data
  for i = 1, select('#', ...) do
    local key = select(i, ...)
    result = result[key]
    if result == nil then
      break
    end
  end
  return result
end

return cfg
