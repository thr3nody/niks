{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Erine Moira";
        email = "me@erine.dev";
        signingkey = "34B83C26F04A401B";
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
      commit = {
        gpgsign = true;
      };
    };
  };
}
