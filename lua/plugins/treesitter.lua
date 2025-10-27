local nix_managed = vim.g.nix_managed
local function setup_treesitter()
  if nix_managed then
    require("nvim-ts-autotag").setup({})
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    })
  end
end

if nix_managed then
  setup_treesitter()
  return {}
end

return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
    	highlight = {
    		enable = true,
    	},
    
    	indent = {
    		enable = true,
    	},
    
    	autotag = {
    		enable = true,
    	},
    
    	ensure_installed = {
    		"lua",
    		"json",
    		"css",
    		"bash",
    		"regex",
    		"c",
    		"markdown",
    		"markdown_inline",
    		"yaml",
    		"html",
    		"cpp",
    		"c_sharp",
    		"java",
    		"nix",
    		"python",
    		"scss",
    		"javascript",
    		"latex",
    		"norg",
    		"typst",
    		"svelte",
    		"tsx",
    		"vue",
    	},
    })
  end,
}