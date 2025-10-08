inputs:
(self: super: {
  vimPlugins = super.vimPlugins // {
    MyLazyVim = super.vimPlugins.LazyVim.overrideAttrs (old: {

      pname = "LazyVim";
      version = old.version;
      src = old.src;

      patches = (old.patches or [ ]) ++ [
        ./replace-default-tokionight-with-catppuccin.patch
      ];
    });
  };
})
