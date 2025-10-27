if vim.g.nix_managed then
	require("cord").setup({})
end

return {
	"vyfor/cord.nvim",
	build = ":Cord update",
	-- opts = {}
}
