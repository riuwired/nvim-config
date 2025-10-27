local function setup_todo_comments ()
  local todo_comments = require("todo-comments")
    local keymap = vim.keymap
      
    keymap.set("n", "]", function()
    	todo_comments.jump_next()
    end, { desc = "Next todo comment" })
    
    keymap.set("n", "[", function()
    	todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })
    
    todo_comments.setup()
  end

if vim.g.nix_managed then
  setup_todo_comments()
  return {}
end

return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = setup_todo_comments,
}