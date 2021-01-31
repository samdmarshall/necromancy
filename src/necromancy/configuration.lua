
local ltui = require("ltui")
local path = require("path")
local struct = require("struct")
local split = require("split")

local cfg = require("necromancy.cfg")
local theme = require("necromancy.theme")
local log = require("necromancy.log")
local events = require("necromancy.events")
local utilities = require("necromancy.utilities")

local configuration = configuration or ltui.object() -- luacheck: globals configuration

local function translate_key(key_name)
  return "<"..key_name..">"
end

configuration.DefaultKeyBindings = {
  [events.command_prompt] = translate_key(":");
  [events.navigate_down] = translate_key("Down");
  [events.navigate_up] = translate_key("Up");
  [events.navigate_left] = translate_key("Left");
  [events.navigate_right] = translate_key("Right");

  [events.cancel] = translate_key("Esc");
  [events.execute] = translate_key("Enter");
  [events.suspend] = translate_key("CtrlZ");
  [events.quit] = translate_key("CtrlQ");
}

function configuration:new(filepath)
  self = self()
  self:init(filepath)
  return self
end

function configuration:init(filepath)
  self._main = cfg:new(filepath)
  local theme_name = self._main:get("color", "theme")
  local theme_path = path.join(path.dirname(filepath), "themes", theme_name)
  self._theme = theme:new(theme_path)
end

function configuration:main()
  return self._main
end

function configuration:get_key(key_name)
  local binding = self._main:get_default(self.DefaultKeyBindings[key_name], "keys", key_name)
  log:debug(key_name.." -> "..binding)
  return binding
end

function configuration:lookup_key(key_name)
  local binding = ""
  for key,value in pairs(self._main:get("keys")) do
    if value == key_name then
      binding = key
      break
    end
  end
  log:debug(key_name.." -> "..binding)
  return binding
end

function configuration:ignore_items()
  local items = {}
  local value = self._main:get("ignore", "items")

  for _,entry in pairs(split.split(value, '\r?\n')) do
    if string.len(entry) > 0 then
      table.insert(items, entry)
    end
  end

  log:info("ignored directory items: "..utilities.dumpstr(items))
  return items
end

function configuration:mouse_enabled()
  if not self._mouse_support then
    self._mouse_support = self._main:get_default(true, "general", "mouse")
  end
  return self._mouse_support
end

function configuration:translate_key(key_name)
  return translate_key(key_name)
end

function configuration:theme()
  return self._theme
end

return configuration
