##  Key constants. See also struct tb_event's key field.
## 
##  These are a safe subset of terminfo keys, which exist on all popular
##  terminals. Termbox uses only them to stay truly portable.
## 

const
  TB_KEY_F1*: uint16 = (0x0000FFFF - 0)
  TB_KEY_F2*: uint16 = (0x0000FFFF - 1)
  TB_KEY_F3*: uint16 = (0x0000FFFF - 2)
  TB_KEY_F4*: uint16 = (0x0000FFFF - 3)
  TB_KEY_F5*: uint16 = (0x0000FFFF - 4)
  TB_KEY_F6*: uint16 = (0x0000FFFF - 5)
  TB_KEY_F7*: uint16 = (0x0000FFFF - 6)
  TB_KEY_F8*: uint16 = (0x0000FFFF - 7)
  TB_KEY_F9*: uint16 = (0x0000FFFF - 8)
  TB_KEY_F10*: uint16 = (0x0000FFFF - 9)
  TB_KEY_F11*: uint16 = (0x0000FFFF - 10)
  TB_KEY_F12*: uint16 = (0x0000FFFF - 11)
  TB_KEY_INSERT*: uint16 = (0x0000FFFF - 12)
  TB_KEY_DELETE*: uint16 = (0x0000FFFF - 13)
  TB_KEY_HOME*: uint16 = (0x0000FFFF - 14)
  TB_KEY_END*: uint16 = (0x0000FFFF - 15)
  TB_KEY_PGUP*: uint16 = (0x0000FFFF - 16)
  TB_KEY_PGDN*: uint16 = (0x0000FFFF - 17)
  TB_KEY_ARROW_UP*: uint16 = (0x0000FFFF - 18)
  TB_KEY_ARROW_DOWN*: uint16 = (0x0000FFFF - 19)
  TB_KEY_ARROW_LEFT*: uint16 = (0x0000FFFF - 20)
  TB_KEY_ARROW_RIGHT*: uint16 = (0x0000FFFF - 21)
  TB_KEY_MOUSE_LEFT*: uint16 = (0x0000FFFF - 22)
  TB_KEY_MOUSE_RIGHT*: uint16 = (0x0000FFFF - 23)
  TB_KEY_MOUSE_MIDDLE*: uint16 = (0x0000FFFF - 24)
  TB_KEY_MOUSE_RELEASE*: uint16 = (0x0000FFFF - 25)
  TB_KEY_MOUSE_WHEEL_UP*: uint16 = (0x0000FFFF - 26)
  TB_KEY_MOUSE_WHEEL_DOWN*: uint16 = (0x0000FFFF - 27)

##  These are all ASCII code points below SPACE character and a BACKSPACE key.

const
  TB_KEY_CTRL_TILDE*: uint16 = 0x00000000
  TB_KEY_CTRL_2*: uint16 = 0x00000000
  TB_KEY_CTRL_A*: uint16 = 0x00000001
  TB_KEY_CTRL_B*: uint16 = 0x00000002
  TB_KEY_CTRL_C*: uint16 = 0x00000003
  TB_KEY_CTRL_D*: uint16 = 0x00000004
  TB_KEY_CTRL_E*: uint16 = 0x00000005
  TB_KEY_CTRL_F*: uint16 = 0x00000006
  TB_KEY_CTRL_G*: uint16 = 0x00000007
  TB_KEY_BACKSPACE*: uint16 = 0x00000008
  TB_KEY_CTRL_H*: uint16 = 0x00000008
  TB_KEY_TAB*: uint16 = 0x00000009
  TB_KEY_CTRL_I*: uint16 = 0x00000009
  TB_KEY_CTRL_J*: uint16 = 0x0000000A
  TB_KEY_CTRL_K*: uint16 = 0x0000000B
  TB_KEY_CTRL_L*: uint16 = 0x0000000C
  TB_KEY_ENTER*: uint16 = 0x0000000D
  TB_KEY_CTRL_M*: uint16 = 0x0000000D
  TB_KEY_CTRL_N*: uint16 = 0x0000000E
  TB_KEY_CTRL_O*: uint16 = 0x0000000F
  TB_KEY_CTRL_P*: uint16 = 0x00000010
  TB_KEY_CTRL_Q*: uint16 = 0x00000011
  TB_KEY_CTRL_R*: uint16 = 0x00000012
  TB_KEY_CTRL_S*: uint16 = 0x00000013
  TB_KEY_CTRL_T*: uint16 = 0x00000014
  TB_KEY_CTRL_U*: uint16 = 0x00000015
  TB_KEY_CTRL_V*: uint16 = 0x00000016
  TB_KEY_CTRL_W*: uint16 = 0x00000017
  TB_KEY_CTRL_X*: uint16 = 0x00000018
  TB_KEY_CTRL_Y*: uint16 = 0x00000019
  TB_KEY_CTRL_Z*: uint16 = 0x0000001A
  TB_KEY_ESC*: uint16 = 0x0000001B
  TB_KEY_CTRL_LSQ_BRACKET*: uint16 = 0x0000001B
  TB_KEY_CTRL_3*: uint16 = 0x0000001B
  TB_KEY_CTRL_4*: uint16 = 0x0000001C
  TB_KEY_CTRL_BACKSLASH*: uint16 = 0x0000001C
  TB_KEY_CTRL_5*: uint16 = 0x0000001D
  TB_KEY_CTRL_RSQ_BRACKET*: uint16 = 0x0000001D
  TB_KEY_CTRL_6*: uint16 = 0x0000001E
  TB_KEY_CTRL_7*: uint16 = 0x0000001F
  TB_KEY_CTRL_SLASH*: uint16 = 0x0000001F
  TB_KEY_CTRL_UNDERSCORE*: uint16 = 0x0000001F
  TB_KEY_SPACE*: uint16 = 0x00000020
  TB_KEY_BACKSPACE2*: uint16 = 0x0000007F
  TB_KEY_CTRL_8*: uint16 = 0x0000007F

##  These are non-existing ones.
## 
##  #define TB_KEY_CTRL_1 clash with '1'
##  #define TB_KEY_CTRL_9 clash with '9'
##  #define TB_KEY_CTRL_0 clash with '0'
## 
## 
##  Alt modifier constant, see tb_event.mod field and tb_select_input_mode function.
##  Mouse-motion modifier
## 

const
  TB_MOD_ALT*: uint8 = 0x00000001
  TB_MOD_MOTION*: uint8 = 0x00000002

##  Colors (see struct tb_cell's fg and bg fields).

const
  TB_DEFAULT* = 0x00000000
  TB_BLACK* = 0x00000001
  TB_RED* = 0x00000002
  TB_GREEN* = 0x00000003
  TB_YELLOW* = 0x00000004
  TB_BLUE* = 0x00000005
  TB_MAGENTA* = 0x00000006
  TB_CYAN* = 0x00000007
  TB_WHITE* = 0x00000008

##  Attributes, it is possible to use multiple attributes by combining them
##  using bitwise OR ('|'). Although, colors cannot be combined. But you can
##  combine attributes and a single color. See also struct tb_cell's fg and bg
##  fields.
## 

const
  TB_BOLD* = 0x00000100
  TB_UNDERLINE* = 0x00000200
  TB_REVERSE* = 0x00000400

##  A cell, single conceptual entity on the terminal screen. The terminal screen
##  is basically a 2d array of cells. It has the following fields:
##   - 'ch' is a unicode character
##   - 'fg' foreground color and attributes
##   - 'bg' background color and attributes
## 

type
  tb_cell* {.importc: "struct tb_cell", header: "termbox.h".} = object
    ch*: uint32
    fg*: uint16
    bg*: uint16


const
  TB_EVENT_KEY* = 1
  TB_EVENT_RESIZE* = 2
  TB_EVENT_MOUSE* = 3

##  An event, single interaction from the user. The 'mod' and 'ch' fields are
##  valid if 'type' is TB_EVENT_KEY. The 'w' and 'h' fields are valid if 'type'
##  is TB_EVENT_RESIZE. The 'x' and 'y' fields are valid if 'type' is
##  TB_EVENT_MOUSE. The 'key' field is valid if 'type' is either TB_EVENT_KEY
##  or TB_EVENT_MOUSE. The fields 'key' and 'ch' are mutually exclusive; only
##  one of them can be non-zero at a time.
## 

type tbevent* {.importc: "struct tb_event", header: "termbox.h".} = object
  `type`*: uint8
  `mod`*: uint8 ##  modifiers to either 'key' or 'ch' below
  key*: uint16 ##  one of the TB_KEY_* constants
  ch*: uint32 ##  unicode character
  w*: int32
  h*: int32
  x*: int32
  y*: int32


##  Error codes returned by tb_init(). All of them are self-explanatory, except
##  the pipe trap error. Termbox uses unix pipes in order to deliver a message
##  from a signal handler (SIGWINCH) to the main event reading loop. Honestly in
##  most cases you should just check the returned code as < 0.
## 

const
  TB_EUNSUPPORTED_TERMINAL* = - 1
  TB_EFAILED_TO_OPEN_TTY* = - 2
  TB_EPIPE_TRAP_ERROR* = - 3

##  Initializes the termbox library. This function should be called before any
##  other functions. Function tb_init is same as tb_init_file("/dev/tty").
##  After successful initialization, the library must be
##  finalized using the tb_shutdown() function.
## 

proc tb_init*(): cint {.importc: "tb_init", header: "termbox.h".}
proc tb_init_file*(name: cstring): cint {.importc: "tb_init_file", header: "termbox.h".}
proc tb_init_fd*(inout: cint): cint {.importc: "tb_init_fd", header: "termbox.h".}
proc tb_shutdown*() {.importc: "tb_shutdown", header: "termbox.h".}
##  Returns the size of the internal back buffer (which is the same as
##  terminal's window size in characters). The internal buffer can be resized
##  after tb_clear() or tb_present() function calls. Both dimensions have an
##  unspecified negative value when called before tb_init() or after
##  tb_shutdown().
## 

proc tb_width*(): cint {.importc: "tb_width", header: "termbox.h".}
proc tb_height*(): cint {.importc: "tb_height", header: "termbox.h".}
##  Clears the internal back buffer using TB_DEFAULT color or the
##  color/attributes set by tb_set_clear_attributes() function.
## 

proc tb_clear*() {.importc: "tb_clear", header: "termbox.h".}
proc tb_set_clear_attributes*(fg: uint16; bg: uint16) {.importc: "tb_set_clear_attributes", header: "termbox.h".}
##  Synchronizes the internal back buffer with the terminal.

proc tb_present*() {.importc: "tb_present", header: "termbox.h".}
const
  TB_HIDE_CURSOR* = - 1

##  Sets the position of the cursor. Upper-left character is (0, 0). If you pass
##  TB_HIDE_CURSOR as both coordinates, then the cursor will be hidden. Cursor
##  is hidden by default.
## 

proc tb_set_cursor*(cx: cint; cy: cint) {.importc: "tb_set_cursor", header: "termbox.h".}
##  Changes cell's parameters in the internal back buffer at the specified
##  position.
## 

proc tb_put_cell*(x: cint; y: cint; cell: ptr tb_cell) {.importc: "tb_put_cell", header: "termbox.h".}
proc tb_change_cell*(x: cint; y: cint; ch: uint32; fg: uint16; bg: uint16) {.importc: "tb_change_cell", header: "termbox.h".}
##  Copies the buffer from 'cells' at the specified position, assuming the
##  buffer is a two-dimensional array of size ('w' x 'h'), represented as a
##  one-dimensional buffer containing lines of cells starting from the top.
## 
##  (DEPRECATED: use tb_cell_buffer() instead and copy memory on your own)
## 

proc tb_blit*(x: cint; y: cint; w: cint; h: cint; cells: ptr tb_cell) {.importc: "tb_blit", header: "termbox.h".}
##  Returns a pointer to internal cell back buffer. You can get its dimensions
##  using tb_width() and tb_height() functions. The pointer stays valid as long
##  as no tb_clear() and tb_present() calls are made. The buffer is
##  one-dimensional buffer containing lines of cells starting from the top.
## 

proc tb_cell_buffer*(): ptr tb_cell {.importc: "tb_cell_buffer", header: "termbox.h".}
const
  TB_INPUT_CURRENT* = 0
  TB_INPUT_ESC* = 1
  TB_INPUT_ALT* = 2
  TB_INPUT_MOUSE* = 4

##  Sets the termbox input mode. Termbox has two input modes:
##  1. Esc input mode.
##     When ESC sequence is in the buffer and it doesn't match any known
##     ESC sequence => ESC means TB_KEY_ESC.
##  2. Alt input mode.
##     When ESC sequence is in the buffer and it doesn't match any known
##     sequence => ESC enables TB_MOD_ALT modifier for the next keyboard event.
## 
##  You can also apply TB_INPUT_MOUSE via bitwise OR operation to either of the
##  modes (e.g. TB_INPUT_ESC | TB_INPUT_MOUSE). If none of the main two modes
##  were set, but the mouse mode was, TB_INPUT_ESC mode is used. If for some
##  reason you've decided to use (TB_INPUT_ESC | TB_INPUT_ALT) combination, it
##  will behave as if only TB_INPUT_ESC was selected.
## 
##  If 'mode' is TB_INPUT_CURRENT, it returns the current input mode.
## 
##  Default termbox input mode is TB_INPUT_ESC.
## 

proc tb_select_input_mode*(mode: cint): cint {.importc: "tb_select_input_mode", header: "termbox.h".}
const
  TB_OUTPUT_CURRENT* = 0
  TB_OUTPUT_NORMAL* = 1
  TB_OUTPUT_256* = 2
  TB_OUTPUT_216* = 3
  TB_OUTPUT_GRAYSCALE* = 4

##  Sets the termbox output mode. Termbox has three output options:
##  1. TB_OUTPUT_NORMAL     => [1..8]
##     This mode provides 8 different colors:
##       black, red, green, yellow, blue, magenta, cyan, white
##     Shortcut: TB_BLACK, TB_RED, ...
##     Attributes: TB_BOLD, TB_UNDERLINE, TB_REVERSE
## 
##     Example usage:
##         tb_change_cell(x, y, '@', TB_BLACK | TB_BOLD, TB_RED);
## 
##  2. TB_OUTPUT_256        => [0..256]
##     In this mode you can leverage the 256 terminal mode:
##     0x00 - 0x07: the 8 colors as in TB_OUTPUT_NORMAL
##     0x08 - 0x0f: TB_* | TB_BOLD
##     0x10 - 0xe7: 216 different colors
##     0xe8 - 0xff: 24 different shades of grey
## 
##     Example usage:
##         tb_change_cell(x, y, '@', 184, 240);
##         tb_change_cell(x, y, '@', 0xb8, 0xf0);
## 
##  2. TB_OUTPUT_216        => [0..216]
##     This mode supports the 3rd range of the 256 mode only.
##     But you don't need to provide an offset.
## 
##  3. TB_OUTPUT_GRAYSCALE  => [0..23]
##     This mode supports the 4th range of the 256 mode only.
##     But you dont need to provide an offset.
## 
##  Execute build/src/demo/output to see its impact on your terminal.
## 
##  If 'mode' is TB_OUTPUT_CURRENT, it returns the current output mode.
## 
##  Default termbox output mode is TB_OUTPUT_NORMAL.
## 

proc tb_select_output_mode*(mode: cint): cint {.importc: "tb_select_output_mode", header: "termbox.h".}
##  Wait for an event up to 'timeout' milliseconds and fill the 'event'
##  structure with it, when the event is available. Returns the type of the
##  event (one of TB_EVENT_* constants) or -1 if there was an error or 0 in case
##  there were no event during 'timeout' period.
## 

proc tb_peek_event*(event: ptr tb_event; timeout: cint): cint {.importc: "tb_peek_event", header: "termbox.h".}
##  Wait for an event forever and fill the 'event' structure with it, when the
##  event is available. Returns the type of the event (one of TB_EVENT_*
##  constants) or -1 if there was an error.
## 

proc tb_poll_event*(event: ptr tb_event): cint {.importc: "tb_poll_event", header: "termbox.h".}
##  Utility utf8 functions.

const
  TB_EOF* = - 1

proc tb_utf8_char_length*(c: char): cint {.importc: "tb_utf8_char_length", header: "termbox.h".}
proc tb_utf8_char_to_unicode*(`out`: ptr uint32; c: cstring): cint {.importc: "tb_utf8_char_to_unicode", header: "termbox.h".}
proc tb_utf8_unicode_to_char*(`out`: cstring; c: uint32): cint {.importc: "tb_utf8_unicode_to_char", header: "termbox.h".}
