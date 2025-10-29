if vim.g.neovide then
  -- configure scaling
  vim.g.neovide_scale_factor = 1.0
  -- configure padding
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  vim.g.neovide_refresh_rate = 240
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_mode = 'railgun'
  vim.g.neovide_opacity = 0.95
end

-- NOTE: this just gives nixCats global command a default value
-- so that it doesnt throw an error if you didnt install via nix.
-- usage of both this setup and the nixCats command is optional,
-- but it is very useful for passing info from nix to lua so you will likely use it at least once.
require('nixCatsUtils').setup {
  non_nix_value = true,
}

-- NOTE: You might want to move the lazy-lock.json file
local function getlockfilepath()
  if require('nixCatsUtils').isNixCats and type(nixCats.settings.unwrappedCfgPath) == 'string' then
    return nixCats.settings.unwrappedCfgPath .. '/lazy-lock.json'
  else
    return vim.fn.stdpath 'config' .. '/lazy-lock.json'
  end
end
local lazyOptions = {
  lockfile = getlockfilepath(),
}

-- NOTE: this the lazy wrapper. Use it like require('lazy').setup() but with an extra
-- argument, the path to lazy.nvim as downloaded by nix, or nil, before the normal arguments.
require('nixCatsUtils.lazyCat').setup(nixCats.pawsible { 'allPlugins', 'start', 'lazy.nvim' }, {
  -- stylua: ignore start

  { 'LazyVim/LazyVim',                           import = 'lazyvim.plugins' },
  -- disable mason.nvim while using nix
  -- precompiled binaries do not agree with nixos, and we can just make nix install this stuff for us.
  { 'mason-org/mason-lspconfig.nvim',            enabled = require('nixCatsUtils').lazyAdd(true, false) },
  { 'mason-org/mason.nvim',                      enabled = require('nixCatsUtils').lazyAdd(true, false) },
  { 'jay-babu/mason.nvim',                       enabled = require('nixCatsUtils').lazyAdd(true, false) },
  { 'WhoIsSethDaniel/mason-tool-installer.nvim', enabled = require('nixCatsUtils').lazyAdd(true, false) },
  { 'mfussenegger/nvim-dap',                     enabled = require('nixCatsUtils').lazyAdd(true, false) },

  -- https://lazy.folke.io/usage/structuring#%EF%B8%8F-importing-specs-config--opts
  -- general
  { import = 'lazyvim.plugins.extras.ui.indent-blankline' },
  { import = 'lazyvim.plugins.extras.ui.mini-animate' },
  { import = 'lazyvim.plugins.extras.ui.mini-indentscope' },
  { import = 'lazyvim.plugins.extras.ui.treesitter-context' },
  { import = 'lazyvim.plugins.extras.editor.outline' }, -- `<leader>cs` : `Toggle Outline`

  { import = 'lazyvim.plugins.extras.lang.git' }, -- we installed all parsers, so this works. see https://www.lazyvim.org/extras/lang/git#nvim-treesitter
  -- rust
  { import = 'lazyvim.plugins.extras.lang.rust',      enabled = require('nixCatsUtils').enableForNixCategory('rust') },
  { import = 'lazyvim.plugins.extras.lang.toml',      enabled = require('nixCatsUtils').enableForNixCategory('rust') },
  -- cpp
  { import = 'lazyvim.plugins.extras.lang.clangd',    enabled = require('nixCatsUtils').enableForNixCategory('cpp') },
  -- nix
  { import = 'lazyvim.plugins.extras.lang.nix',       enabled = require('nixCatsUtils').enableForNixCategory('nix') },
  -- pyton
  { import = 'lazyvim.plugins.extras.lang.python',    enabled = require('nixCatsUtils').enableForNixCategory('python') },

  -- stylua: ignore end
  {
    'nvim-treesitter/nvim-treesitter',
    -- build = require('nixCatsUtils').lazyAdd ':TSUpdate',
    opts_extend = require('nixCatsUtils').lazyAdd(nil, false),
    opts = {
      -- nix already ensured they were installed, and we would need to change the parser_install_dir if we wanted to use it instead.
      -- so we just disable install and do it via nix.
      ensure_installed = require('nixCatsUtils').lazyAdd({ 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' }, {}),
      auto_install = require('nixCatsUtils').lazyAdd(true, false),
    },
  },
  {
    'folke/lazydev.nvim',
    opts = {
      library = {
        { path = (nixCats.nixCatsPath or '') .. '/lua', words = { 'nixCats' } },
      },
    },
  },
  -- import/override with your plugins
  { import = 'plugins' },
}, lazyOptions)
