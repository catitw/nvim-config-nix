# the overlay style is copied from [nvim-treesitter-nvim overlay](https://github.com/iofq/nvim-treesitter-main/blob/1f19cc0a907328d8dbf467ee9fe216277628d366/overlay.nix#L56)
inputs:
(final: prev: {
  vimPlugins = prev.vimPlugins.extend (
    final': prev': {
      MyLazyVim = prev'.LazyVim.overrideAttrs (old: rec {
        pname = "LazyVim";
        version = old.version;
        src = old.src;

        patches = (old.patches or [ ]) ++ [
          ./replace-default-tokionight-with-catppuccin.patch
        ];
      });
    }
  );
})
