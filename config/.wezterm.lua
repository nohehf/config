-- Note: to test temporary config: https://github.com/wez/wezterm/issues/4238#issuecomment-2295092917
-- tldr; ctrl+shift+l to bring overlay
-- get config with fullconfig = window:effective_config()
-- modify with overrides = window:get_config_overrides() or wezterm.config_builder()
-- overrides = window:get_config_overrides() or wezterm.config_builder()
-- overrides.font_size = 18.0
-- window:set_config_overrides(overrides)

-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrains Mono")
config.window_background_opacity = 0.5
config.macos_window_background_blur = 30

-- hide config top bar
config.window_decorations = "RESIZE"

-- hide tabs if only one is present
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
	-- cmd + d to split horizontally
	{ key = "d", mods = "CMD", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	-- cmd + shift + d to split vertically
	{ key = "d", mods = "CMD|SHIFT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	-- close pane on cmd + w
	{ key = "w", mods = "CMD", action = act({ CloseCurrentPane = { confirm = true } }) },

	-- rebind to iterm defaults
	-- opt letft/right to move by word
	{ mods = "OPT", key = "LeftArrow", action = act.SendKey({ mods = "ALT", key = "b" }) },
	{ mods = "OPT", key = "RightArrow", action = act.SendKey({ mods = "ALT", key = "f" }) },
	-- cmd left/right to move to start/end of line
	{ mods = "CMD", key = "LeftArrow", action = act.SendKey({ mods = "CTRL", key = "a" }) },
	{ mods = "CMD", key = "RightArrow", action = act.SendKey({ mods = "CTRL", key = "e" }) },
	-- cmd backspace to delete to start of line
	{ mods = "CMD", key = "Backspace", action = act.SendKey({ mods = "CTRL", key = "u" }) },
}

-- and finally, return the configuration to wezterm
return config
