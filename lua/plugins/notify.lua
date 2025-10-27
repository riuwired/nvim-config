if vim.g.nix_managed then
	require("notify").setup({})
	vim.notify = notify
	return {}
end

return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")
		notify.setup({
			background_colour = "#000000",
		})
		vim.notify = notify
	end,
}