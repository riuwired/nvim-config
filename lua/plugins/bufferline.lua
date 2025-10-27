local nix_managed = vim.g.nix_managed

local function setup_bufferline()
	if nix_managed then
		require("nvim-web-devicons").setup({})
	end

	local bufferline = require("bufferline")

	bufferline.setup({
		options = {
			mode = "tabs",
			separator_style = "slant",
		},
	})
end

if nix_managed then
	setup_bufferline()
	return {}
end

return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = setup_bufferline,
}
