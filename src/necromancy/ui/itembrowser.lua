
local ltui = require("ltui")

local itembrowser = itembrowser or ltui.choicebox() -- luacheck: globals itembrowser


-- load a item with value
function itembrowser:_load_item(value, index, selected)
  -- init text
  local text = (selected and " " or " ") .. tostring(value) .. " "

  -- init a value item view
  local item = ltui.button:new("choicebox.value." .. index,
    ltui.rect:new(0, index - 1, self:width(), 1),
    text,
    function (v, e)
      self:_do_select()
    end
  )

  -- attach index and value
  item:extra_set("index", index)
  item:extra_set("value", value)
  return item
end

-- do select the current config
function itembrowser:_do_select()
  -- clear selected text
  for v in self:views() do
    local text = v:text()
    if text and text:startswith(" ") then
      local t = v:extra("value")
      -- v:text_set(" " .. tostring(t) .. " ")
    end
  end

  -- get the current item
  local item = self:current()

  -- do action: on selected
  local index = item:extra("index")
  local value = item:extra("value")
  self:action_on(ltui.action.ac_on_selected, index, value)

  -- if value == ".." then
  --   -- move up directory
  -- elseif value.endswith("/") then
  --   -- move down directory
  -- else
  --   -- open item
  -- end

  -- update text
  -- item:text_set(" " .. tostring(value) .. " ")
end

return itembrowser
