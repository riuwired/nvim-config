{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vim-maximizer = {
      url = "github:szw/vim-maximizer";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    packages = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};
        lib = pkgs.lib;

        vim-maximizer-plugin = pkgs.vimUtils.buildVimPlugin {
          pname = "vim-maximizer";
          version = inputs.vim-maximizer.lastModifiedDate;
          src = inputs.vim-maximizer;
        };

        bins = with pkgs; [
          inputs.alejandra.packages.${system}.default
          prettier
          clang-tools
          stylua
          kdePackages.qtdeclarative
          black
          isort

          lua-language-server
          nil
          pyright

          tree-sitter
          gnumake
          fd
          ripgrep
          fzf
          lua
          wget
          git
          ghostscript
          lazygit
          psmisc
          sqlite
          sqlite-interactive
          imagemagick
          mermaid-cli
          tectonic

          nodejs
          gcc
          clang
          cargo
          glib
          (python313.withPackages (ps: with ps; [pynvim watchdog]))
          stdenv.cc
          tree-sitter-grammars.tree-sitter-norg
        ];

        plugins = with pkgs.vimPlugins; [
          nvim-treesitter.withAllGrammars
          lualine-nvim
          nvim-lspconfig
          plenary-nvim
          telescope-nvim
          bufferline-nvim
          nvim-cmp
          nvim-autopairs
          todo-comments-nvim
          trouble-nvim
          which-key-nvim
          nvim-surround
          substitute-nvim
          snacks-nvim
          nvim-notify
          conform-nvim
          (cord-nvim.overrideAttrs (_: {doCheck = false;}))
          indent-blankline-nvim
          nvim-ts-context-commentstring
          comment-nvim
          alpha-nvim
          vim-tmux-navigator
          cmp-buffer
          cmp-path
          luasnip
          cmp_luasnip
          friendly-snippets
          lspkind-nvim
          nvim-tree-lua
          telescope-fzf-native-nvim
          nvim-ts-autotag
          none-ls-nvim
          cmp-nvim-lsp
          neodev-nvim
          nvim-web-devicons
          nvim-lsp-file-operations
          vim-maximizer-plugin
        ];
        neovimCfg = pkgs.writeShellScriptBin "nvim" ''
          export PATH="${pkgs.lib.makeBinPath bins}:''${PATH}"
          exec ${pkgs.neovim.override {
            vimAlias = true;

            configure = {
              customRC = ''
                lua vim.g.nix_managed = true
                lua vim.opt.runtimepath:prepend("${./.}")
                luafile ${./init.lua}
              '';

              packages.myPlugins = with pkgs.vimPlugins; {
                start = plugins;
              };

              extraPackages = bins;
            };
          }}/bin/nvim "$@"
        '';
      in {
        default = neovimCfg.overrideAttrs (old: {
          lua = pkgs.neovim-unwrapped.lua;
          meta =
            (old.meta or {})
            // {
              description = "My neovim configuration";
              longDescription = ''
                custom neovim config with plugins and lsp.
              '';
              license = lib.licenses.gpl3;
              platforms = supportedSystems;
              teams = [];
              maintainers = with lib.maintainers; [riu];
            };
        });
      }
    );
  };
}
