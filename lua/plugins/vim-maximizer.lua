if vim.g.nix_managed then
  vim.keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", {
    desc = "Maximize/minimize a split",
    silent = true
  })
end

return {
  "szw/vim-maximizer",
  
  keys = {
    { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
  },
}