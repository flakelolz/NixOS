{ ... }: {
  home-manager.sharedModules = [
    ({pkgs, ... }: {
      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
      };
    })
  ];
}
