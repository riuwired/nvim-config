-- Plugin-specific theme configurations using matugen colors
-- This module provides setup functions for various plugins

local M = {}

-- Get colors from global or load fresh
local function get_colors()
	if _G.matugen_colors then
		return _G.matugen_colors
	end
	
	local COLORS_PATH = vim.fn.expand("~/.cache/matugen/nvim-colors.lua")
	if vim.fn.filereadable(COLORS_PATH) == 1 then
		local chunk = loadfile(COLORS_PATH)
		if chunk then
			local ok, colors = pcall(chunk)
			if ok then
				-- Add derived colors
				local function lighten(hex, amount)
					hex = hex:gsub("#", "")
					local r = tonumber(hex:sub(1, 2), 16)
					local g = tonumber(hex:sub(3, 4), 16)
					local b = tonumber(hex:sub(5, 6), 16)
					local factor = amount / 100.0
					if factor > 0 then
						r = math.floor(r + (255 - r) * factor)
						g = math.floor(g + (255 - g) * factor)
						b = math.floor(b + (255 - b) * factor)
					else
						r = math.floor(r * (1 + factor))
						g = math.floor(g * (1 + factor))
						b = math.floor(b * (1 + factor))
					end
					return string.format("#%02x%02x%02x",
						math.max(0, math.min(255, r)),
						math.max(0, math.min(255, g)),
						math.max(0, math.min(255, b)))
				end
				
				colors.bg_light = lighten(colors.bg, 10)
				colors.bg_lighter = lighten(colors.bg, 20)
				colors.bg_dark = lighten(colors.bg, -10)
				colors.fg_dark = lighten(colors.fg, -20)
				colors.comment = colors.outline
				
				return colors
			end
		end
	end
	
	return nil
end

-- Telescope
function M.setup_telescope()
	local colors = get_colors()
	if not colors then return end
	
	require("telescope").setup({
		defaults = {
			borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		},
	})
	
	-- Apply highlight groups
	local hi = vim.api.nvim_set_hl
	hi(0, "TelescopeBorder", { fg = colors.outline, bg = "NONE" })
	hi(0, "TelescopePromptBorder", { fg = colors.primary, bg = "NONE" })
	hi(0, "TelescopeResultsBorder", { fg = colors.outline, bg = "NONE" })
	hi(0, "TelescopePreviewBorder", { fg = colors.outline, bg = "NONE" })
	hi(0, "TelescopeSelection", { fg = colors.fg, bg = colors.bg_light })
	hi(0, "TelescopeSelectionCaret", { fg = colors.primary, bg = colors.bg_light })
	hi(0, "TelescopeMatching", { fg = colors.primary, bold = true })
	hi(0, "TelescopePromptPrefix", { fg = colors.primary })
end

-- Neo-tree
function M.setup_neotree()
	local colors = get_colors()
	if not colors then return end
	
	local hi = vim.api.nvim_set_hl
	hi(0, "NeoTreeNormal", { fg = colors.fg, bg = colors.bg })
	hi(0, "NeoTreeNormalNC", { fg = colors.fg, bg = colors.bg })
	hi(0, "NeoTreeDirectoryIcon", { fg = colors.blue })
	hi(0, "NeoTreeDirectoryName", { fg = colors.blue })
	hi(0, "NeoTreeFileName", { fg = colors.fg })
	hi(0, "NeoTreeFileIcon", { fg = colors.fg_dark })
	hi(0, "NeoTreeGitAdded", { fg = colors.green })
	hi(0, "NeoTreeGitModified", { fg = colors.yellow })
	hi(0, "NeoTreeGitDeleted", { fg = colors.red })
	hi(0, "NeoTreeGitUntracked", { fg = colors.cyan })
	hi(0, "NeoTreeIndentMarker", { fg = colors.comment })
	hi(0, "NeoTreeRootName", { fg = colors.primary, bold = true })
end

-- Nvim-tree
function M.setup_nvimtree()
	local colors = get_colors()
	if not colors then return end
	
	local hi = vim.api.nvim_set_hl
	hi(0, "NvimTreeNormal", { fg = colors.fg, bg = colors.bg })
	hi(0, "NvimTreeFolderIcon", { fg = colors.blue })
	hi(0, "NvimTreeFolderName", { fg = colors.blue })
	hi(0, "NvimTreeOpenedFolderName", { fg = colors.blue, bold = true })
	hi(0, "NvimTreeRootFolder", { fg = colors.primary, bold = true })
	hi(0, "NvimTreeGitDirty", { fg = colors.yellow })
	hi(0, "NvimTreeGitNew", { fg = colors.green })
	hi(0, "NvimTreeGitDeleted", { fg = colors.red })
	hi(0, "NvimTreeIndentMarker", { fg = colors.comment })
end

-- Bufferline
function M.setup_bufferline()
	local colors = get_colors()
	if not colors then return end
	
	require("bufferline").setup({
		options = {
			separator_style = "thin",
			indicator = { style = "underline" },
		},
		highlights = {
			fill = { bg = colors.bg_dark },
			background = { fg = colors.fg_dark, bg = colors.bg_dark },
			buffer_visible = { fg = colors.fg_dark, bg = colors.bg_dark },
			buffer_selected = {
				fg = colors.fg,
				bg = colors.bg,
				bold = true,
				italic = false,
			},
			close_button = { fg = colors.fg_dark, bg = colors.bg_dark },
			close_button_visible = { fg = colors.fg_dark, bg = colors.bg_dark },
			close_button_selected = { fg = colors.red, bg = colors.bg },
			modified = { fg = colors.yellow, bg = colors.bg_dark },
			modified_visible = { fg = colors.yellow, bg = colors.bg_dark },
			modified_selected = { fg = colors.yellow, bg = colors.bg },
			separator = { fg = colors.bg, bg = colors.bg_dark },
			separator_visible = { fg = colors.bg, bg = colors.bg_dark },
			separator_selected = { fg = colors.bg, bg = colors.bg },
			indicator_selected = { fg = colors.primary, bg = colors.bg },
			tab = { fg = colors.fg_dark, bg = colors.bg_dark },
			tab_selected = { fg = colors.fg, bg = colors.bg },
			tab_close = { fg = colors.red, bg = colors.bg_dark },
		},
	})
end

-- Which-key
function M.setup_whichkey()
	local colors = get_colors()
	if not colors then return end
	
	local hi = vim.api.nvim_set_hl
	hi(0, "WhichKey", { fg = colors.primary })
	hi(0, "WhichKeyGroup", { fg = colors.cyan })
	hi(0, "WhichKeyDesc", { fg = colors.fg })
	hi(0, "WhichKeySeparator", { fg = colors.comment })
	hi(0, "WhichKeyFloat", { bg = colors.bg_light })
	hi(0, "WhichKeyBorder", { fg = colors.outline, bg = colors.bg_light })
end

-- Notify
function M.setup_notify()
	local colors = get_colors()
	if not colors then return end
	
	require("notify").setup({
		background_colour = colors.bg,
	})
	
	local hi = vim.api.nvim_set_hl
	hi(0, "NotifyERRORBorder", { fg = colors.red })
	hi(0, "NotifyWARNBorder", { fg = colors.yellow })
	hi(0, "NotifyINFOBorder", { fg = colors.cyan })
	hi(0, "NotifyDEBUGBorder", { fg = colors.comment })
	hi(0, "NotifyTRACEBorder", { fg = colors.magenta })
	hi(0, "NotifyERRORTitle", { fg = colors.red })
	hi(0, "NotifyWARNTitle", { fg = colors.yellow })
	hi(0, "NotifyINFOTitle", { fg = colors.cyan })
	hi(0, "NotifyDEBUGTitle", { fg = colors.comment })
	hi(0, "NotifyTRACETitle", { fg = colors.magenta })
end

-- Alpha (dashboard)
function M.setup_alpha()
	local colors = get_colors()
	if not colors then return end
	
	local hi = vim.api.nvim_set_hl
	hi(0, "AlphaHeader", { fg = colors.primary })
	hi(0, "AlphaButtons", { fg = colors.cyan })
	hi(0, "AlphaShortcut", { fg = colors.yellow })
	hi(0, "AlphaFooter", { fg = colors.comment, italic = true })
end

-- Indent-blankline
function M.setup_indent_blankline()
	local colors = get_colors()
	if not colors then return end
	
	local hi = vim.api.nvim_set_hl
	hi(0, "IblIndent", { fg = colors.bg_lighter })
	hi(0, "IblScope", { fg = colors.primary })
end

-- Gitsigns
function M.setup_gitsigns()
	local colors = get_colors()
	if not colors then return end
	
	local hi = vim.api.nvim_set_hl
	hi(0, "GitSignsAdd", { fg = colors.green })
	hi(0, "GitSignsChange", { fg = colors.yellow })
	hi(0, "GitSignsDelete", { fg = colors.red })
	hi(0, "GitSignsCurrentLineBlame", { fg = colors.comment, italic = true })
end

-- Noice
function M.setup_noice()
	local colors = get_colors()
	if not colors then return end
	
	local hi = vim.api.nvim_set_hl
	hi(0, "NoiceCmdlinePopup", { fg = colors.fg, bg = colors.bg_light })
	hi(0, "NoiceCmdlinePopupBorder", { fg = colors.primary, bg = colors.bg_light })
	hi(0, "NoiceCmdlineIcon", { fg = colors.primary })
	hi(0, "NoiceConfirm", { fg = colors.fg, bg = colors.bg_light })
	hi(0, "NoiceConfirmBorder", { fg = colors.primary, bg = colors.bg_light })
end

-- Cmp (completion)
function M.setup_cmp()
	local colors = get_colors()
	if not colors then return end
	
	local hi = vim.api.nvim_set_hl
	hi(0, "CmpItemAbbrMatch", { fg = colors.primary, bold = true })
	hi(0, "CmpItemAbbrMatchFuzzy", { fg = colors.primary })
	hi(0, "CmpItemKindFunction", { fg = colors.blue })
	hi(0, "CmpItemKindMethod", { fg = colors.blue })
	hi(0, "CmpItemKindVariable", { fg = colors.cyan })
	hi(0, "CmpItemKindKeyword", { fg = colors.red })
	hi(0, "CmpItemKindText", { fg = colors.fg })
	hi(0, "CmpItemKindConstant", { fg = colors.magenta })
	hi(0, "CmpItemKindModule", { fg = colors.yellow })
	hi(0, "CmpItemMenu", { fg = colors.comment })
end

-- Setup all plugins
function M.setup_all()
	local plugins = {
		"telescope",
		"neotree",
		"nvimtree",
		"bufferline",
		"whichkey",
		"notify",
		"alpha",
		"indent_blankline",
		"gitsigns",
		"noice",
		"cmp",
	}
	
	for _, plugin in ipairs(plugins) do
		local ok, _ = pcall(M["setup_" .. plugin])
		if ok then
			-- Plugin setup successful (silently)
		end
	end
end

return M