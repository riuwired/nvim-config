local nix_managed = vim.g.nix_managed

local function setup_substitute()
  local substitute = require("substitute")

  substitute.setup({})

  local keymap = vim.keymap 

  keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
  keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
  keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
  keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
end

if nix_managed then
  setup_substitute()
  return {}
end

return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = setup_substitute,
}