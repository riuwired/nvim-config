local nix_managed = vim.g.nix_managed
require("core")
require("matugen").setup()

if nix_managed then
	local nix_loader = require("config.nix-loader")
	nix_loader.load_config()
else
	require("config.lazy")
	require("plugins")
end

-- the first step to never being touched by a woman is to install neovim
-- im two steps ahead, because i already have nixos