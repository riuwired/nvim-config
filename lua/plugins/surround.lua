if vim.g.nix_managed then
  require("nvim-surround").setup({})
end

return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  config = true,
}