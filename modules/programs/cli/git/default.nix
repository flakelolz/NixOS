
{...}: {
  home-manager.sharedModules = [
    (_: {
      programs.git = {
        enable = true;
        userName  = "flakelolz";
        userEmail = "michaelgonzalez.code@gmail.com";
      };
    })
  ];
}
