local nix_managed = vim.g.nix_managed

local function setup_nvim_cmp()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")

  if nix_managed then
    local ok_path, cmp_path = pcall(require, "cmp_path")
    if ok_path and cmp_path and cmp_path.setup then cmp_path.setup({}) end

    local ok_buffer, cmp_buffer = pcall(require, "cmp_buffer")
    if ok_buffer and cmp_buffer and cmp_buffer.setup then cmp_buffer.setup({}) end
    
    local ok_luasnip_cmp, cmp_luasnip = pcall(require, "cmp_luasnip")
    if ok_luasnip_cmp and cmp_luasnip and cmp_luasnip.setup then cmp_luasnip.setup({}) end

    local ok_friendly, friendly_snippets = pcall(require, "friendly-snippets")
    if ok_friendly and friendly_snippets and friendly_snippets.setup then friendly_snippets.setup({}) end

    luasnip.setup({})
    lspkind.setup({})
  end
  
  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,preview,noselect",
    },

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-m>"] = cmp.mapping.scroll_docs(-4),
      ["<C-n>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    }),

    formatting = {
      format = lspkind.cmp_format({
        maxwidth = 50,
        ellipsis_char = "...",
      }),
    },
  })
end

if nix_managed then
  setup_nvim_cmp()
  return {}
end

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp", },
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
  },
  config = setup_nvim_cmp,
}
