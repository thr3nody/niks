{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Erine Moira";
        email = "me@erine.dev";
      };
      alias = {
        pu = "push";
        co = "checkout";
        ci = "commit -v";
        cm = "commit -m";
        br = "branch";
        st = "status";
        di = "diff";
      };
      pull = {
        rebase = false;
      };
    };
  };
}
