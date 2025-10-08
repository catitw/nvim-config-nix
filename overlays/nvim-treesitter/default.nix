inputs:
(self: super: {
  vimPlugins = super.vimPlugins // {
    nvim-treesitter-main = super.vimPlugins.nvim-treesitter.overrideAttrs (old: {
      pname = "nvim-treesitter";
      version = "main";

      # [lazyvim 15.x changes](https://www.lazyvim.org/news#15x)
      # - migrated to nvim-treesitter main branch
      #   - with the new version, the tree-sitter cli is required to install parsers
      src = inputs.nvim-treesitter-main;
    });
  };
})