local nix_managed = vim.g.nix_managed

local function setup_conform()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			html = { "prettier" },
			json = { "prettier" },
			css = { "prettier" },
			yaml = { "prettier" },
			python = { "isort", "black" },
			nix = { "alejandra" },
			qml = { "qmlformat" },
			cpp = { "astyle", "clang-format" },
			c = { "astyle", "clang-format" },
			lua = { "stylua" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		},
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" }),
	})
end

if nix_managed then
	setup_conform()
	return {}
end

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = setup_conform,
}
