
local struct = require("struct")

local colormap = {}

ColorMap = struct {
  default = {},
  black = {},
  red = {},
  green = {},
  yellow = {},
  blue = {},
  magenta = {},
  cyan = {},
  white = {},
}

colormap.DefaultColorMap = ColorMap {
  default = DefaultDefault,
  black = DefaultBlack,
  red = DefaultRed,
  green = DefaultGreen,
  yellow = DefaultYellow,
  blue = DefaultBlue,
  magenta = DefaultMagenta,
  cyan = DefaultCyan,
  white = DefaultWhite
}


return colormap
