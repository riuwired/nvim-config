local nix_managed = vim.g.nix_managed
local null_ls = require("null-ls")

local function setup_none_ls()
  null_ls.setup({
    null_ls.builtins.formatting.qmlformat,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.alejandra,
  })
end
local function setup_conform()
	require("conform").setup({
    formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			nix = { "alejandra" },
			c = { "clang-format" },
      cpp = { "clang-format" },
			qml = { "qmlformat" },
		},
	})
end

if nix_managed then
  setup_none_ls()
  setup_conform()
  return {}
end

return {
  
}