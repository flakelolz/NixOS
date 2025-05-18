{ ... }: {
  home-manager.sharedModules = [
    ({pkgs, ... }: {
      programs.starship = {
        enable = true;
        settings = pkgs.lib.importTOML ./starship.toml;
      };
    })
  ];
}
