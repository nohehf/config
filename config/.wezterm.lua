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
-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Material Palenight (base16)"
-- config.color_scheme = "Hybrid (terminal.sexy)"
-- config.color_scheme = "dracula (official)"  -- a bit too bright
-- config.color_scheme = "dracula"
-- rosepine
-- local rosepine_theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main
-- config.colors = rosepine_theme.colors()
-- config.window_frame = rosepine_theme.window_frame()
config.color_scheme = "Tokyo Night"
config.font = wezterm.font("JetBrains Mono")

config.window_background_opacity = 0.9
config.macos_window_background_blur = 40

-- hide config top bar
config.window_decorations = "RESIZE"

-- hide tabs if only one is present
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- enable hyperlinks
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Key Mappings
config.keys = {
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

	-- select pane with cmd + option + arrow
	{ key = "RightArrow", mods = "CMD|OPT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "LeftArrow", mods = "CMD|OPT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "UpArrow", mods = "CMD|OPT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "DownArrow", mods = "CMD|OPT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },

	-- clipboard
	{ key = "c", mods = "CMD", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },

	-- split vertically (top / bottom)
	{ key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- split horizontally (left | right)
	{ key = "d", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
}

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
-- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config, {
	-- the default config is here, if you'd like to use the default keys,
	-- you can omit this configuration table parameter and just use
	-- smart_splits.apply_to_config(config)

	-- directional keys to use in order of: left, down, up, right
	direction_keys = { "h", "j", "k", "l" },
	-- if you want to use separate direction keys for move vs. resize, you
	-- can also do this:
	-- modifier keys to combine with direction_keys
	modifiers = {
		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
		resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
	},
	-- log level to use: info, warn, error
	log_level = "info",
})

-- ctrl + click or cmd + click to open link
config.mouse_bindings = {
	-- Disable the default click behavior
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.DisableDefaultAssignment,
	},
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
	-- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.Nop,
	},
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = wezterm.action.Nop,
	},
}

-- dim inactive pane
config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.7,
}

-- and finally, return the configuration to wezterm
return config
