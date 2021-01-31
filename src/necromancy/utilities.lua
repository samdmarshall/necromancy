
local utilities = {}

function utilities.contains(table, value)
  for _, v in pairs(table) do
    if v == value then
      return true
    end
  end
  return false
end

function utilities.dumpstr(table)
  local repr = ""
  repr = repr.."{"
  for k,v in pairs(table) do
    if type(k) ~= nil then
      repr = repr.." "..tostring(k).." ".."=".." "
    end
    if tostring(type(v)) == table then
      repr = repr..utilities.dumpstr(v)..","
    else
      repr = repr..tostring(v)..","
    end
  end
  repr = repr.."}"
  return repr
end

return utilities
