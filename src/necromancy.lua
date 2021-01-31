#!/usr/bin/env lua

--
-- Imports
--
local ltui = require("ltui")
local path = require("path")
local argparse = require("argparse")
local ee = require("EventEmitter")
local lfs = require("lfs")
local filesize = require("filesize")

local configuration = require("necromancy.configuration")
local log = require("necromancy.log")
local events = require("necromancy.events")
local actionhandler = require("necromancy.action")
local utilities = require("necromancy.utilities")
local itembrowser = require("necromancy.ui.itembrowser")

--
local AppName = "necromancy"
local VersionNumber = "0.1.0"

--
local necromancy = ltui.application()

--
-- Properties
--
function necromancy:config()
  return self._config
end

function necromancy:body_window()
  if not self._BODY_WINDOW then
    self._BODY_WINDOW = ltui.window:new("window.body", ltui.rect {1, 1, self:width() - 1, self:height() - 1}, "main window")
  end
  return self._BODY_WINDOW
end

function necromancy:item_browser()
  if not self._item_browser then
    self._item_browser = itembrowser:new("necromancy.itembrowser", ltui.rect {1, 1, self:width() - 2, self:height() - 2})
    self._item_browser:state_set("focused", true)
  end
  return self._item_browser
end

function necromancy:cwd()
  return self._cwd
end

function necromancy:cwd_set(new_path)
  if not path.exists(new_path) then
    log:warn("invalid path! ("..new_path..")")
  end
  self._cwd = path.fullpath(new_path)
end

-- function necromancy:test_event()
--   if not self._TESTE then
--     self._TESTE = ltui.label:new('necromancy.label', ltui.rect {0, 0, self:width() - 1, 2}, ' ')
--   end
--   return self._TESTE
-- end

--
-- Methods
--
function necromancy:path_update(new_path)
  log:info("updating current directory path!")
  local full_path = path.fullpath(new_path)
  if path.exists(full_path) then
    self:cwd_set(new_path)
    self:body_window():title():text_set(self:cwd())
    local items = {}

    for name in lfs.dir(self:cwd()) do
      if name ~= "." and name ~= ".." then
        local name_path = path.join(self:cwd(), name)
        local attrs = lfs.symlinkattributes(name_path)
        table.insert(items, name)
      end
    end

    self:item_browser():load(items, 0)
  else
    log:error("invalid path supplied!")
  end
end

function necromancy:init(name, argv)
  -- Default Values
  local current_working_directory = path.currentdir()
  local default_config_path = path.join(path.user_home(), ".config", "necromancy", "config.cfg")

  ee.extend_object(self)
  self:on(events.quit, self.exit)

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

  self:cwd_set(self._args.cwd)

  self._handler = actionhandler:new()
  self:on(events.change_path, function(obj, event, new_path) obj:path_update(new_path) end)

  log:print("Initializing GUI...")
  ltui.application.init(self, AppName, argv)

  local background_color = self._config:theme():value_get("background")
  self:background_set(background_color)
  self:insert(self:body_window())

  self:emit(events.change_path, self._args.cwd)

  self:body_window():panel():insert(self:item_browser())

  -- self:body_window():panel():insert(self:test_event())

  -- local config_details = ltui.textarea:new('config.details', ltui.rect {0, 0, self:width() - 1, 10})
  -- config_details:text_set()
  -- self:body_window():panel():insert(config_details)
end

function necromancy:on_resize()
  log:info("Performing resize..")
  self:body_window():bounds_set(ltui.rect {1, 1, self:width() - 1, self:height() - 1})
  ltui.application.on_resize(self)
end

function necromancy:on_event(e)
  log:info("Recieved event: "..utilities.dumpstr(e))
  if e.type < ltui.event.ev_max then
  --   self:test_event():text_set(
  --     'type: ' .. tostring(e.type) ..
  --     '; name: ' .. tostring(event_name) ..
  --     '; code: ' .. tostring(e.key_code or e.x) ..
  --     '; meta: ' .. tostring(e.key_code or e.y)
  --   )
    self._handler:perform(self, e)
  end
  ltui.application.on_event(self, e)
end

function necromancy:exit()
  log:info("Exiting...")
  ltui.application:exit()
  os.exit(0)
end

necromancy:run()
