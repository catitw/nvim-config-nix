-- https://www.lazyvim.org/plugins/editor#flashnvim
return {
  'folke/flash.nvim',
  -- stylua: ignore
  keys = {
    -- disable the default keymap for incremental selection
    -- see https://www.lazyvim.org/configuration/plugins#%EF%B8%8F-adding--disabling-plugin-keymaps
    { "<c-space>",  false },
    
    -- Simulate nvim-treesitter incremental selection
    { "<CR>", mode = { "n", "o", "x" },
      function()
        require("flash").treesitter({
          actions = {
            ["<CR>"] = "next",  -- Enter:       incremental selection
            ["<BS>"] = "prev"   -- Backspace:   decremental selection
          }
        }) 
      end, desc = "Treesitter Incremental Selection" },
  },
}
