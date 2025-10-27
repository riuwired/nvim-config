if vim.g.nix_managed then
  require("todo-comments").setup({})
  require("nvim-web-devicons").setup({})

  require("trouble").setup({
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostic" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Open trouble document diagnostic" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Open trouble quickfix list" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Open trouble location list" },
      { "<leader>xt", "<cmd>Todo Trouble<CR>", desc = "Open todos in trouble" },
    }
  })
end

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list" },
    { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostic" },
    { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Open trouble document diagnostic" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Open trouble quickfix list" },
    { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Open trouble location list" },
    { "<leader>xt", "<cmd>Todo Trouble<CR>", desc = "Open todos in trouble" },
  }
}