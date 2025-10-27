return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			" 888       888 8888888 8888888b.  8888888888 8888888b.  ",
			" 888   o   888   888   888   Y88b 888        888  'Y88b ",
			" 888  d8b  888   888   888    888 888        888    888 ",
			" 888 d888b 888   888   888   d88P 8888888    888    888 ",
			" 888d88888b888   888   8888888P'  888        888    888 ",
			" 88888P Y88888   888   888 T88b   888        888    888 ",
			" 8888P   Y8888   888   888  T88b  888        888  .d88P ",
			" 888P     Y888 8888888 888   T88b 8888888888 8888888P'  ",
		}

		dashboard.section.buttons.val = {
			dashboard.button("e", " > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC ee", " > Toggle File Explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fs", " > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("q", " > Quit Neovim", "<cmd>qa<CR>"),
		}

		alpha.setup(dashboard.opts)

		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}