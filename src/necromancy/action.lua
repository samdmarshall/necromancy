
local ltui = require("ltui")

local configuration = require("necromancy.configuration")
local events = require("necromancy.events")
local log = require("necromancy.log")
local command = require("necromancy.command")

local actionhandler = actionhandler or ltui.object() -- luacheck: globals actionhandler

function actionhandler:new(bindings)
  self = self()
  self:init()
  return self
end

function actionhandler:init(bindings)
  self._bindings = {}
  self._active_input = false
  self._command_string = ""
end

function actionhandler:has_active_input()
  return self._active_input
end

function actionhandler:perform(app, e)
  local name = e.key_name or e.btn_name
  local event_name = configuration:translate_key(name)

  local binding = app:config():lookup_key(event_name)

  if self._active_input then
    -- check for the user canceling or executing the input command string
    local is_execute_event = binding == events.execute
    local is_cancel_event = binding == events.cancel
    local is_relevant_event = is_cancel_event or is_execute_event

    if is_relevant_event then
      -- Disable receiving active input
      self._active_input = false

      -- Cancel event (hit the escape key)
      if is_cancel_event then
        log:error("canceling command input! ("..self._command_string..")")
      end

      -- Execute event (hit the enter key)
      if is_execute_event then
        log:error("executing command input! ("..self._command_string..")")
      end

      -- Clear the command string as we are done with it now.
      self._command_string = ""
    else

      -- Keyboard Event
      if e.type == ltui.event.ev_keyboard then

        -- Append the name of the keyboard event to the command string buffer
        self._command_string = self._command_string .. e.key_name
      end

      -- Mouse Event
      if e.type == ltui.event.ev_mouse and app:config():mouse_enabled() then

        local position = ltui.point {
          x = e.x,
          y = e.y
        }
        local button = e.btn_name

      end

    end

  else
    -- General events received from application event handler, these are mapped to key bindings

    if binding == events.quit then
      log:notice("emitting event: quit")
      app:emit("quit")
    elseif binding == events.navigate_up then
      log:notice("emitting event: item selection up")
      app:emit(events.navigate_up)
    elseif binding == events.navigate_down then
      log:notice("emitting event: item selection down")
      app:emit(events.navigate_down)
    elseif binding == events.navigate_left then
      log:notice("emitting event: depth navigation out")
      app:emit(events.navigate_left)
    elseif binding == events.navigate_right then
      log:notice("emitting event: depth navigation in")
      app:emit(events.navigate_right)
    elseif binding == events.command_prompt then
      log:notice("emitting event: activate command prompt")
      self._active_input = true
      app:emit(events.command_prompt)
    else
      log:print("unknown action")
    end
  end
end

return actionhandler
