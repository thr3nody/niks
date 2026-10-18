{
  programs.nixvim.plugins.markview = {
    enable = true;
    settings.preview = {
      enable = false;
      modes = ["n" "no" "c"];
      hybrid_modes = ["i"];
    };
  };
}
