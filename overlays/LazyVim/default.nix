inputs:
(self: super: {
  vimPlugins = super.vimPlugins // {
    MyLazyVim = super.vimPlugins.LazyVim.overrideAttrs (old: {

      pname = "LazyVim";
      version = "2025-05-12";
      src = super.fetchFromGitHub {
        owner = "LazyVim";
        repo = "LazyVim";
        rev = "25abbf546d564dc484cf903804661ba12de45507";
        sha256 = "0q1jhpij75ps2fkincrq59dsqlzyacm2m0c783b9dgm3vz783xnl";
      };

      patches = (old.patches or [ ]) ++ [
        ./replace-default-tokionight-with-catppuccin.patch
      ];
    });
  };
})
