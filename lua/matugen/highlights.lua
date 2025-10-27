-- Matugen highlight definitions
-- All base Neovim highlight groups

local M = {}

local function hi(group, opts)
	local cmd = "highlight " .. group
	if opts.fg then cmd = cmd .. " guifg=" .. opts.fg end
	if opts.bg then cmd = cmd .. " guibg=" .. opts.bg end
	if opts.gui then cmd = cmd .. " gui=" .. opts.gui end
	if opts.sp then cmd = cmd .. " guisp=" .. opts.sp end
	vim.cmd(cmd)
end

function M.apply(colors)
	-- Clear and reset
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
	vim.o.termguicolors = true
	vim.g.colors_name = "matugen"

	-- Editor UI
	hi("Normal", { fg = colors.fg, bg = colors.bg })
	hi("NormalFloat", { fg = colors.fg, bg = colors.bg_light })
	hi("FloatBorder", { fg = colors.outline, bg = colors.bg_light })
	hi("LineNr", { fg = colors.comment })
	hi("CursorLine", { bg = colors.bg_light })
	hi("CursorLineNr", { fg = colors.yellow, bg = colors.bg_light })
	hi("Visual", { bg = colors.bg_lighter })
	hi("Search", { fg = colors.bg, bg = colors.yellow })
	hi("IncSearch", { fg = colors.bg, bg = colors.primary })
	hi("Pmenu", { fg = colors.fg, bg = colors.surface })
	hi("PmenuSel", { fg = colors.bg, bg = colors.primary })
	hi("PmenuSbar", { bg = colors.surface_variant or colors.bg_light })
	hi("PmenuThumb", { bg = colors.primary })
	hi("StatusLine", { fg = colors.fg, bg = colors.surface })
	hi("StatusLineNC", { fg = colors.comment, bg = colors.surface })
	hi("TabLine", { fg = colors.comment, bg = colors.surface })
	hi("TabLineSel", { fg = colors.fg, bg = colors.bg })
	hi("TabLineFill", { bg = colors.surface })
	hi("VertSplit", { fg = colors.outline })
	hi("WinSeparator", { fg = colors.outline })
	hi("SignColumn", { bg = colors.bg })
	hi("Folded", { fg = colors.comment, bg = colors.bg_light })
	hi("FoldColumn", { fg = colors.comment, bg = colors.bg })

	-- Syntax
	hi("Comment", { fg = colors.comment, gui = "italic" })
	hi("Constant", { fg = colors.magenta })
	hi("String", { fg = colors.green })
	hi("Character", { fg = colors.green })
	hi("Number", { fg = colors.magenta })
	hi("Boolean", { fg = colors.magenta })
	hi("Float", { fg = colors.magenta })
	hi("Identifier", { fg = colors.blue })
	hi("Function", { fg = colors.blue })
	hi("Statement", { fg = colors.red })
	hi("Conditional", { fg = colors.red })
	hi("Repeat", { fg = colors.red })
	hi("Label", { fg = colors.red })
	hi("Operator", { fg = colors.cyan })
	hi("Keyword", { fg = colors.red })
	hi("Exception", { fg = colors.red })
	hi("PreProc", { fg = colors.yellow })
	hi("Include", { fg = colors.cyan })
	hi("Define", { fg = colors.cyan })
	hi("Macro", { fg = colors.cyan })
	hi("Type", { fg = colors.yellow })
	hi("StorageClass", { fg = colors.yellow })
	hi("Structure", { fg = colors.yellow })
	hi("Typedef", { fg = colors.yellow })
	hi("Special", { fg = colors.cyan })
	hi("SpecialChar", { fg = colors.cyan })
	hi("Error", { fg = colors.red, gui = "bold" })
	hi("Todo", { fg = colors.yellow, gui = "bold" })
	hi("Underlined", { gui = "underline" })
	hi("Title", { fg = colors.primary, gui = "bold" })

	-- Treesitter
	hi("@variable", { fg = colors.fg })
	hi("@variable.builtin", { fg = colors.magenta })
	hi("@variable.parameter", { fg = colors.fg })
	hi("@variable.member", { fg = colors.cyan })
	hi("@function", { fg = colors.blue })
	hi("@function.builtin", { fg = colors.cyan })
	hi("@function.method", { fg = colors.blue })
	hi("@keyword", { fg = colors.red })
	hi("@keyword.function", { fg = colors.red })
	hi("@keyword.operator", { fg = colors.red })
	hi("@keyword.return", { fg = colors.red })
	hi("@string", { fg = colors.green })
	hi("@string.escape", { fg = colors.cyan })
	hi("@string.special", { fg = colors.cyan })
	hi("@number", { fg = colors.magenta })
	hi("@boolean", { fg = colors.magenta })
	hi("@comment", { fg = colors.comment, gui = "italic" })
	hi("@operator", { fg = colors.cyan })
	hi("@punctuation.bracket", { fg = colors.fg_dark })
	hi("@punctuation.delimiter", { fg = colors.fg_dark })
	hi("@type", { fg = colors.yellow })
	hi("@type.builtin", { fg = colors.yellow })
	hi("@property", { fg = colors.cyan })
	hi("@parameter", { fg = colors.fg })
	hi("@constant", { fg = colors.magenta })
	hi("@constant.builtin", { fg = colors.magenta })
	hi("@constructor", { fg = colors.yellow })
	hi("@tag", { fg = colors.red })
	hi("@tag.attribute", { fg = colors.cyan })
	hi("@tag.delimiter", { fg = colors.fg_dark })

	-- LSP
	hi("DiagnosticError", { fg = colors.red })
	hi("DiagnosticWarn", { fg = colors.yellow })
	hi("DiagnosticInfo", { fg = colors.cyan })
	hi("DiagnosticHint", { fg = colors.blue })
	hi("DiagnosticUnderlineError", { sp = colors.red, gui = "undercurl" })
	hi("DiagnosticUnderlineWarn", { sp = colors.yellow, gui = "undercurl" })
	hi("DiagnosticUnderlineInfo", { sp = colors.cyan, gui = "undercurl" })
	hi("DiagnosticUnderlineHint", { sp = colors.blue, gui = "undercurl" })
	hi("LspReferenceText", { bg = colors.bg_light })
	hi("LspReferenceRead", { bg = colors.bg_light })
	hi("LspReferenceWrite", { bg = colors.bg_light })
	hi("LspSignatureActiveParameter", { fg = colors.yellow, gui = "bold" })

	-- Git
	hi("DiffAdd", { fg = colors.green, bg = colors.bg_light })
	hi("DiffChange", { fg = colors.yellow, bg = colors.bg_light })
	hi("DiffDelete", { fg = colors.red, bg = colors.bg_light })
	hi("DiffText", { fg = colors.blue, bg = colors.bg_lighter })
	hi("GitSignsAdd", { fg = colors.green })
	hi("GitSignsChange", { fg = colors.yellow })
	hi("GitSignsDelete", { fg = colors.red })

	-- Telescope
	hi("TelescopeBorder", { fg = colors.outline })
	hi("TelescopeSelection", { bg = colors.bg_light })
	hi("TelescopeMatching", { fg = colors.primary, gui = "bold" })

	-- Which-key
	hi("WhichKey", { fg = colors.primary })
	hi("WhichKeyGroup", { fg = colors.cyan })
	hi("WhichKeyDesc", { fg = colors.fg })
	hi("WhichKeySeparator", { fg = colors.comment })

	-- Neo-tree
	hi("NeoTreeDirectoryIcon", { fg = colors.blue })
	hi("NeoTreeDirectoryName", { fg = colors.blue })
	hi("NeoTreeGitModified", { fg = colors.yellow })
	hi("NeoTreeGitAdded", { fg = colors.green })
	hi("NeoTreeGitDeleted", { fg = colors.red })
end

return M