
return {
  "catitw/wildfire.nvim",
  event = "BufEnter",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    -- <CR>   (ENTER)           : incremental selection
    -- <S-CR> (SHIFT + ENTER)   : decremental selection
    keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<S-CR>",
    },
  },
}