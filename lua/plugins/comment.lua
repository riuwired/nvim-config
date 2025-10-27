local nix_managed = vim.g.nix_managed

local function setup_comment()
  local ok_comment, comment = pcall(require, "Comment")
  if not ok_comment then 
    vim.notify("Comment.nvim failed to load.", vim.log.levels.ERROR)
    return 
  end

  local ok_ts_ctx, ts_ctx = pcall(require, "nvim_ts_context_commentstring")
  local ok_ts_integration, ts_context_commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")

  if nix_managed and ok_ts_ctx and ts_ctx and ts_ctx.setup then
    ts_ctx.setup({})
  end

  local comment_config = {}

  if ok_ts_integration and ts_context_commentstring and ts_context_commentstring.create_pre_hook then
    comment_config.pre_hook = ts_context_commentstring.create_pre_hook()
  end
  
  comment.setup(comment_config)

end

if nix_managed then
  setup_comment()
  return {}
end

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = setup_comment,
}