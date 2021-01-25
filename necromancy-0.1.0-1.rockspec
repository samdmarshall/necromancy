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
   "lua-struct >= 1.1",
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
      ["necromancy.vendor.ini"] = "src/necromancy/vendor/ini.lua"
   }
}
