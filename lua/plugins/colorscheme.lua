local nix_managed = vim.g.nix_managed
local function setup_colorscheme()
	vim.cmd.colorscheme("pywal16")
	local pywal16 = require("pywal16")
	pywal16.setup({})
end

if nix_managed then
	setup_colorscheme()
	return {}
end

return {
	"fueguchi/pywal16.nvim",
	priority = 1000,
	config = setup_colorscheme,
}
