{...}: {
  home-manager.sharedModules = [
    (_: {
      home.shellAliases = {
        vi = "nvim";
      };
      programs.neovim.enable = true;
      home.file.".config/nvim" = {
        source = builtins.fetchGit {
          url = "https://github.com/flakelolz/nvim.git";
          rev = "4e65c9cb649d3cabf315689a0daaec422d3d606c";
        };
        recursive = true;
      };
    })
  ];
}
