local function setup_autopairs()
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")

  cmp.event:on("config_done", cmp_autopairs.on_confirm_done())
end

if vim.g.nix_managed then
  require("nvim-autopairs").setup({})
  require("cmp").setup({})
  setup_autopairs()
  return {}
end

return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
    })

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("config_done", cmp_autopairs.on_confirm_done())
  end,
}
