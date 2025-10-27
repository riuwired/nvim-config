local nix_managed = vim.g.nix_managed

local function setup_which_key()
  vim.keymap.set("n", "?", function()
    require("which-key").show({ global = false })
  end, { desc = "Buffer Local Keymaps (which-key)" })
end

if nix_managed then
  setup_which_key()
  return {}
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
	  {
	  	"<leader>?",
	  	function()
	  		require("which-key").show({ global = false })
	  	end,
	  	desc = "Buffer Local Keymaps (which-key)",
	  },
  }
}