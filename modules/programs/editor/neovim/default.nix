{ inputs, ... }:
{ home-manager.sharedModules = [
    ({ pkgs, lib, config, ... }:
      {
        home.shellAliases = {
          vi = "nvim";
        };
        programs.neovim.enable = true;

        home.activation.copyNeovimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          echo "Copying Neovim config..."
          rm -rf ~/.config/nvim
          cp -r ${inputs.nvim-config.configDir} ~/.config/nvim
          chmod -R u+rw ~/.config/nvim
        '';
      }
    )
  ];
}
