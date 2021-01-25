#!/usr/bin/env lua

local ltui = require("ltui")
local path = require("path")
local argparse = require("argparse")
local configuration = require("necromancy/configuration")
local log = require("necromancy/log")
local actionhandler = require("necromancy.action")

local AppName = "necromancy"
local VersionNumber = "0.1.0"

local necromancy = ltui.application()

function necromancy:init(name, argv)
  -- Default Values
  local current_working_directory = path.currentdir()
  local default_config_path = path.join(path.user_home(), ".config", "necromancy", "config.cfg")

  local cli = argparse(argv) {
    name = AppName,
    description = "Simple TUI File Browser"
  }
  cli:argument("input") {
    target = "cwd",
    description = "Specify the path to browse from",
    default = "./",
    args = "0-1"
  }
  cli:option("--config") {
    target = "configuration_path",
    description = "Path to load necromancy config from",
    default = default_config_path,
    args = 1
  }
  cli:flag("--trace") {
    target = "trace",
    description = "Enable log tracing",
    action = "store_true",
    default = false
  }
  cli:flag("-v --version") {
    description = "Show version information",
    action = function(...) print(AppName.." v"..VersionNumber) os.exit(0) end
  }

  log:print("Parsing command line arguments...")
  self._args = cli:parse(argv)

  log:print("Parsing configuration file...")
  self._config = configuration:new(self._args.configuration_path)

  self._handler = actionhandler:new()

  log:print("Initializing GUI...")
  ltui.application.init(self, AppName, argv)

  self:background_set(self._config._theme:default_get("black"))
  self:insert(self:body_window())

  -- self:body_window():panel():insert(self:test_event())

  -- local config_details = ltui.textarea:new('config.details', ltui.rect {0, 0, self:width() - 1, 10})
  -- config_details:text_set()
  -- self:body_window():panel():insert(config_details)
end

function necromancy:body_window()
  if not self._BODY_WINDOW then
    self._BODY_WINDOW = ltui.window:new("window.body", ltui.rect {1, 1, self:width() - 1, self:height() - 1}, "main window", true)
  end
  return self._BODY_WINDOW
end

function necromancy:on_resize()
  self:body_window():bounds_set(ltui.rect {1, 1, self:width() - 1, self:height() - 1})
  ltui.application.on_resize(self)
end

-- function necromancy:test_event()
--   if not self._TESTE then
--     self._TESTE = ltui.label:new('necromancy.label', ltui.rect {0, 0, self:width() - 1, 2}, ' ')
--   end
--   return self._TESTE
-- end

function necromancy:on_event(e)
  if e.type < ltui.event.ev_max then
  --   self:test_event():text_set(
  --     'type: ' .. tostring(e.type) ..
  --     '; name: ' .. tostring(event_name) ..
  --     '; code: ' .. tostring(e.key_code or e.x) ..
  --     '; meta: ' .. tostring(e.key_code or e.y)
  --   )
    self._handler:perform(self._config, e)
  end
  ltui.application.on_event(self, e)
end

necromancy:run()
