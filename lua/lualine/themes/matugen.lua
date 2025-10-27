-- Get colors from global (set by matugen module)
local colors = _G.matugen_colors or {
	bg = "#202020",
	fg = "#c0c0c0",
	red = "#ff0000",
	green = "#00ff00",
	blue = "#0000ff",
	yellow = "#ffff00",
	magenta = "#ff00ff",
	cyan = "#00ffff",
	primary = "#8080ff",
	surface = "#303030",
	outline = "#505050",
}

return {
	normal = {
		a = { fg = colors.bg, bg = colors.primary, gui = "bold" },
		b = { fg = colors.fg, bg = colors.surface },
		c = { fg = colors.fg, bg = colors.bg },
	},
	insert = {
		a = { fg = colors.bg, bg = colors.green, gui = "bold" },
		b = { fg = colors.fg, bg = colors.surface },
	},
	visual = {
		a = { fg = colors.bg, bg = colors.magenta or colors.primary, gui = "bold" },
		b = { fg = colors.fg, bg = colors.surface },
	},
	replace = {
		a = { fg = colors.bg, bg = colors.red, gui = "bold" },
		b = { fg = colors.fg, bg = colors.surface },
	},
	command = {
		a = { fg = colors.bg, bg = colors.yellow or colors.secondary, gui = "bold" },
		b = { fg = colors.fg, bg = colors.surface },
	},
	inactive = {
		a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
		b = { fg = colors.fg, bg = colors.bg },
		c = { fg = colors.outline, bg = colors.bg },
	},
}