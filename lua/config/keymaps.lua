-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- reference:
-- - https://www.reddit.com/r/AstroNvim/comments/1hkb6pr/remap_toggle_comment_to_ctrl
-- - https://github.com/LazyVim/LazyVim/discussions/3033
map({ 'n', 'v' }, '<leader>/', 'gcc', { remap = true, desc = 'Toggle comment' })

if vim.g.neovide then
  map('v', '<C-S-c>', '"+y') -- Copy in visual mode
  map('v', '<C-S-v>', '"+P') -- Paste in visual mode

  map('n', '<C-S-v>', '"+P') -- Paste in normal mode

  map('c', '<C-S-v>', '<C-R>+') -- Paste in command mode

  map('i', '<C-S-v>', '<C-R>+') -- Paste in insert mode
end
