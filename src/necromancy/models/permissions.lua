
local lfs = require("lfs")
local path = require("path")
local split = require("split")

local log = require("necromancy.log")
local utilities = require("necromancy.utilities")

local permissions = {}

function permissions._set_parse(set_string)
  local result = {
    read = false,
    write = false,
    execute = false
  }

  for i,value in pairs(split.split(set_string, "")) do
    if i == 1 then
      result["read"] = value == "r"
    elseif i == 2 then
      result["write"] = value == "w"
    elseif i == 3 then
      result["execute"] = value == "x"
    end
  end

  return result
end

function permissions._set_string(set_table)
  local result = ""

  local read_bit = set_table["read"]
  if read_bit then
    result = result.."r"
  else
    result = result.."-"
  end

  local write_bit = set_table["write"]
  if write_bit then
    result = result.."w"
  else
    result = result.."-"
  end

  local execute_bit = set_table["execute"]
  if execute_bit then
    result = result.."x"
  else
    result = result.."-"
  end

  return result
end

function permissions.parse(permission_string)
  -- log:print(permission_string)
  local captures = table.pack(string.find(permission_string, "([r%-][w%-][x%-])([r%-][w%-][x%-])([r%-][w%-][x%-])"))
  -- local start_index, end_index, owner, group, other = table.unpack(captures)
  -- log:print(owner)
  -- log:print(group)
  -- log:print(other)
  local result = {
    owner = permissions._set_parse(captures[3]),
    group = permissions._set_parse(captures[4]),
    other = permissions._set_parse(captures[5])
  }
  return result
end

function permissions.as_string(permission_table)
  local result = ""
  for group,set in pairs(permission_table) do
    result = result..permissions._set_string(set)
  end
  return result
end

function permissions.is_executable(permission_table)
  local result = false
  result = permission_table["owner"]["execute"] or permission_table["group"]["execute"] or permission_table["other"]["execute"]
  return result
end

return permissions
