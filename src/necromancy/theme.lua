
local ltui = require("ltui")
local path = require("path")
local struct = require("struct")

local cfg = require("necromancy.cfg")
local utilities = require("necromancy.utilities")
local color = require("necromancy.models.color")
local colormap = require("necromancy.models.colormap")
local log = require("necromancy.log")

local theme = theme or cfg() -- luacheck: globals theme

theme.defaults = {}
theme.defaults.colors = color.defaults
theme.defaults.map = colormap.DefaultColorMap

Theme = struct {
  background = color.DefaultBlack,
  map = colormap.DefaultColorMap,
  file = color.DefaultDefault,
  directory = color.DefaultGreen,
  executable = color.DefaultBlue,
  symlink = color.DefaultMagenta
}

local DefaultTheme = Theme {}

function theme:new(filepath)
  self = self()
  self:init(filepath)
  return self
end

function theme:init(filepath)
  cfg.init(self, filepath)
end

function theme:default_get(name)
  if name == "default" then
    return color.DefaultDefault
  elseif name == "black" then
    return color.DefaultBlack
  elseif name == "red" then
    return color.DefaultRed
  elseif name == "green" then
    return color.DefaultGreen
  elseif name == "yellow" then
    return color.DefaultYellow
  elseif name == "blue" then
    return color.DefaultBlue
  elseif name == "magenta" then
    return color.DefaultMagenta
  elseif name == "cyan" then
    return color.DefaultCyan
  elseif name == "white" then
    return color.DefaultWhite
  else
    return nil
  end
end

function theme:value_get(property)
  local result = nil
  if utilities.contains({"background", "file", "directory", "executable", "symlink"}, property) then
    result = self:get("theme", property)
  end
  return result
end

function theme:color_get(name)
  if utilities.contains(color.names, name) then
    local default = self:default_get(name)
    return Color {
      normal = self:get(name, "normal"),
      bold = self:get(name, "bold"),
      underline = self:get(name, "underline")
    }
  end
  return self:default_get(name)
end


return theme
