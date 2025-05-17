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
          rev = "167303d78c4536123e32b9a0c9b0a519e74af1ad";
        };
        recursive = true;
      };
    })
  ];
}
