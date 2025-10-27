local M = {}

local function safe_require(module_name)
	local ok, result = pcall(require, module_name)
	if not ok then
		vim.notify("Failed to load module: " .. module_name .. " - " .. result, vim.log.levels.ERROR)
		return nil
	end
	return result
end

local function load_plugin_config(plugin_spec)
	if type(plugin_spec) == "table" and plugin_spec.config then
		if type(plugin_spec.config) == "function" then
			local ok, err = pcall(plugin_spec.config)
			if not ok then
				vim.notify("Error in plugin config: " .. err, vim.log.levels.ERROR)
			end
		end
	end
end

M.load_config = function()
	local matugen = safe_require("matugen")
	if matugen then
		matugen.setup()
		vim.notify("🎨 Matugen colors loaded", vim.log.levels.INFO)
	end
end

M.load_config = function()
	local plugin_modules = {
		"plugins.lsp.format",
		"plugins.lsp.lspconfig",
		"plugins.telescope",
		"plugins.nvim-tree",
		"plugins.todo-comments",
		"plugins.bufferline",
		"plugins.lualine",
		"plugins.which-key",
		"plugins.indent-blankline",
		"plugins.snacks",
		"plugins.nvim-autopair",
		"plugins.treesitter",
		"plugins.trouble",
		"plugins.cmp",
		"plugins.vim-maximizer",
		"plugins.comment",
		"plugins.formatting",
		"plugins.surround",
		"plugins.notify",
	}
	for _, module_name in ipairs(plugin_modules) do
		local plugin_spec = safe_require(module_name)
		if plugin_spec then
			load_plugin_config(plugin_spec)
			-- Obsviously its usefull for debug purpouses only, such a annoying warning
			-- vim.notify("Successfully loaded: " .. module_name, vim.log.levels.INFO)
		end
	end
end

return M
