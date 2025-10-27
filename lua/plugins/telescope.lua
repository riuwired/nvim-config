local nix_managed = vim.g.nix_managed

local function setup_telescope_nvim()
	if nix_managed then
		pcall(require, "plenary")
		pcall(require, "telescope-fzf-native")
		pcall(require, "nvim-web-devicons")
		pcall(require, "todo-comments")
	end

	local telescope = require("telescope")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			path_display = { "smart" },
			mappings = {
				i = {
					["<C-k>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
					["<C-q>"] = actions.send_selected_to_qflist,
				},
			},
			file_ignore_patterns = { ".git/", ".mypy_cache/" },
		},

		pickers = {
			find_files = {
				hidden = true,
			},
		},

		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	})

	local ok, _ = pcall(telescope.load_extension, "fzf")
	if not ok then
		vim.notify("Failed to load telescope fzf extension", vim.log.levels.WARN)
	end

	local keymap = vim.keymap

	keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {
		desc = "Fuzzy find files in cwd",
	})
	keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", {
		desc = "Fuzzy find recent files",
	})
	keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", {
		desc = "Find string in cwd",
	})
	keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", {
		desc = "Find string under cursor in cwd",
	})
	keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", {
		desc = "Find todos",
	})
end

if nix_managed then
	setup_telescope_nvim()
	return {}
end

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = setup_telescope_nvim,
}