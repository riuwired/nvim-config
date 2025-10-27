local nix_managed = vim.g.nix_managed
local keymap = vim.keymap

local default_capabilities = vim.lsp.protocol.make_client_capabilities()

local function setup_lspconfig()
  local lspconfig = require("lspconfig")

  local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local ok_mason, mason_lspconfig = pcall(require, "mason-lspconfig")

  local capabilities = default_capabilities
  if ok_cmp and cmp_nvim_lsp and cmp_nvim_lsp.default_capabilities then
      capabilities = cmp_nvim_lsp.default_capabilities()
  end
  
  if nix_managed then
    if ok_cmp then require("cmp_nvim_lsp").setup({}) end

    local ok_fileops, fileops = pcall(require, "nvim-lsp-file-operations")
    if ok_fileops then fileops.setup({}) end

    local ok_neodev, neodev = pcall(require, "neodev")
    if ok_neodev then neodev.setup({}) end
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local opts = {
        buffer = ev.buf,
        silent = true,
      }

      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ": LspRestart<CR>", opts)
    end,
  })

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "󰌵",
        [vim.diagnostic.severity.INFO] = "",
      },
    },
  })

  if ok_mason and not nix_managed then
    mason_lspconfig.setup({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
    })
  end
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "antosha417/nvim-lsp-file-operations",
      config = true,
    },
    {
      "folke/neodev.nvim",
      opts = {},
    },
  },
  config = setup_lspconfig,
}
