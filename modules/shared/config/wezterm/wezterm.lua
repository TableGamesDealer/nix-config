-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- set the default shell
config.default_prog = { "/bin/zsh", "-l" }

-- For example, changing the initial geometry for new windows:
config.initial_cols = 88
config.initial_rows = 24

-- or, changing the font size and color scheme.
config.font_size = 16
-- config.color_scheme = 'AdventureTime'

-- Optional tab bar
config.enable_tab_bar = false

-- resizing text size will resize window
config.adjust_window_size_when_changing_font_size = false

config.window_decorations = "RESIZE"

-- If set to true, when there is only a single tab, the tab bar is hidden from the display. If a second tab is created, the tab will be shown.
config.hide_tab_bar_if_only_one_tab = true
-- disables close window prompt!
config.window_close_confirmation = "NeverPrompt"

local act = wezterm.action

config.keys = {
  -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
  {
    key = "LeftArrow",
    mods = "OPT",
    action = act.SendKey({
      key = "b",
      mods = "ALT",
    }),
  },
  {
    key = "RightArrow",
    mods = "OPT",
    action = act.SendKey({ key = "f", mods = "ALT" }),
  },
  {
    key = "Backspace",
    mods = "CMD",
    action = act.SendString("\x15"),
  },
}

-- Finally, return the configuration to wezterm:
return config
