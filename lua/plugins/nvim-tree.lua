local nix_managed = vim.g.nix_managed

local function setup_nvim_tree()
	if nix_managed then
    require("nvim-web-devicons").setup()
  end
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	require("nvim-tree").setup({
		view = {
			width = 30,
			relativenumber = false,
		},
		renderer = {
			indent_markers = {
				enable = true,
			},
			icons = {
				glyphs = {
					folder = {
						arrow_closed = "",
						arrow_open = "",
					},
				},
			},
		},
		actions = {
			open_file = {
				window_picker = {
					enable = false,
				},
			},
		},
		git = {
			ignore = false,
		},
	})

	local keymap = vim.keymap
	keymap.set("n", "<leader>te", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })
	keymap.set("n", "<leader>tf", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer" })
	keymap.set("n", "<leader>tc", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse nvim-tree" })
	keymap.set("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh nvim-tree" })
end

if nix_managed then
	setup_nvim_tree()
	return
end

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = setup_nvim_tree,
}