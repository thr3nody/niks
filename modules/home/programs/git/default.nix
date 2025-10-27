{
  programs.git = {
    enable = true;
    settings = {
      aliases = {
        pu = "push";
        co = "checkout";
        cm = "commit -m";
      };
      user = {
        name = "Erine";
        email = "me@erine.dev";
      };
    };
  };
}
