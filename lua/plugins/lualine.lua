local nix_managed = vim.g.nix_managed

local function setup_lualine_nvim()
	if nix_managed then
		require("nvim-web-devicons").setup({})
	end

	local lualine = require("lualine")
	lualine.setup({
		options = {
			theme = "matugen",
		},
	})
end

if nix_managed then
	setup_lualine_nvim()
	return {}
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = setup_lualine_nvim,
}
