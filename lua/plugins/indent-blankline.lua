local nix_managed = vim.g.nix_managed
local function setup_indent_blankline()
  require("ibl").setup({
  indent = { char = "┊" },
  scope = { enabled = true },
})
end

if nix_managed then
  setup_indent_blankline()
end

return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		indent = { char = "┊" },
		scope = { enabled = true },
	},
}
