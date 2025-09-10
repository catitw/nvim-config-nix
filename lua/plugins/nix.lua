local catUtils = require 'nixCatsUtils'
local get_nixd_opts = nixCats.extra 'nixdExtras.get_configs'

return {
  'neovim/nvim-lspconfig',
  enabled = catUtils.isNixCats and (nixCats 'nix'),
  opts = {
    servers = {
      -- disable default LazyVim lsp config
      nil_ls = false,
      -- https://sbulav.github.io/vim/neovim-setting-up-nixd/
      -- https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md#where-to-place-the-configuration
      -- https://github.com/BirdeeHub/birdeevim/blob/ac618327a5e34995283e904da048411aae0f3ec6/lua/birdee/LSPs/nixlua.lua#L1
      nixd = {
        settings = {
          nixd = {
            nixpkgs = {
              -- ''import ${pkgs.path} {}''
              expr = nixCats.extra 'nixdExtras.nixpkgs' or 'import <nixpkgs> {}',
            },
            formatting = {
              command = { 'nixfmt' },
            },
            options = {
              -- (builtins.getFlake "path:${builtins.toString <path_to_system_flake>}").legacyPackages.<system>.nixosConfigurations."<user@host>".options
              nixos = {
                expr = get_nixd_opts and get_nixd_opts('nixos', nixCats.extra 'nixdExtras.flake-path'),
              },
              -- (builtins.getFlake "path:${builtins.toString <path_to_system_flake>}").legacyPackages.<system>.homeConfigurations."<user@host>".options
              ['home-manager'] = {
                expr = get_nixd_opts and get_nixd_opts('home-manager', nixCats.extra 'nixdExtras.flake-path'), -- <-  if flake-path is nil it will be lsp root dir
              },
            },
            diagnostic = {
              suppress = {
                'sema-escaping-with',
              },
            },
          },
        },
      },
    },
  },
}
