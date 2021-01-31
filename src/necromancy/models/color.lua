
local struct = require("struct")

local color = {}

Color = struct {
  normal = "",
  bold = "",
  underline = "",
}

color.DefaultDefault = Color {
  normal = "default",
  bold = "bold",
  underline = "underline",
}

color.DefaultBlack = Color {
  normal = "black",
  bold = "bold",
  underline = "underline",
}

color.DefaultRed = Color {
  normal = "red",
  bold = "bold",
  underline = "underline",
}

color.DefaultGreen = Color {
  normal = "green",
  bold = "bold",
  underline = "underline",
}

color.DefaultYellow = Color {
  normal = "yellow",
  bold = "bold",
  underline = "underline",
}

color.DefaultBlue = Color {
  normal = "blue",
  bold = "bold",
  underline = "underline",
}

color.DefaultMagenta = Color {
  normal = "magenta",
  bold = "bold",
  underline = "underline",
}

color.DefaultCyan = Color {
  normal = "cyan",
  bold = "bold",
  underline = "underline",
}

color.DefaultWhite = Color {
  normal = "white",
  bold = "bold",
  underline = "underline",
}

color.name = {"default", "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"}
color.defaults = {color.DefaultDefault, color.DefaultBlack, color.DefaultRed, color.DefaultGreen, color.DefaultYellow, color.DefaultBlue, color.DefaultMagenta, color.DefaultCyan, color.DefaultWhite}

return color
