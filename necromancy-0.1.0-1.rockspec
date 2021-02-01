package = "necromancy"
version = "0.1.0-1"
source = {
   url = "git://github.com/samdmarshall/necromancy"
}
description = {
   homepage = "https://github.com/samdmarshall/necromancy",
   summary = "Simple TUI File Browser",
   license = "BSD-3 Clause License",
   detailed = [[ ]],
}
dependencies = {
   "lua >= 5.3",
   "lpeg >= 1.0.2",
   "ltui >= 2.5",
   "argparse >= 0.7.1",
   "lua-path >= 0.3.1",
   "luastruct >= 1.1",
   "eventemitter >= 0.1.1",
   "split >= 3.2.1",
   "lua-filesize >= 0.1.1",
   "luafilesystem >= 1.8.0",
}
build = {
   type = "builtin",
   modules = {
      ["necromancy"] = "src/necromancy.lua",
      ["necromancy.action"] = "src/necromancy/action.lua",
      ["necromancy.events"] = "src/necromancy/events.lua",
      ["necromancy.command"] = "src/necromancy/command.lua",
      ["necromancy.cfg"] = "src/necromancy/cfg.lua",
      ["necromancy.log"] = "src/necromancy/log.lua",
      ["necromancy.configuration"] = "src/necromancy/configuration.lua",
      ["necromancy.theme"] = "src/necromancy/theme.lua",
      ["necromancy.utilities"] = "src/necromancy/utilities.lua",
      ["necromancy.models.color"] = "src/necromancy/models/color.lua",
      ["necromancy.models.colormap"] = "src/necromancy/models/colormap.lua",
      ["necromancy.models.permissions"] = "src/necromancy/models/permissions.lua",
      ["necromancy.ui.itembrowser"] = "src/necromancy/ui/itembrowser.lua",
      ["necromancy.vendor.ini"] = "src/necromancy/vendor/ini.lua"
   }
}
