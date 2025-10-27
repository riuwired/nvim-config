return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = function()
			local servers = {
				"lua_ls",
				"nil_ls",
				"pyright",
				"html",
				"cssls",
				"emmet_ls",
				"clangd",
				"qmlls",
			}
      automatic_installation = true,
    end,
	},
}