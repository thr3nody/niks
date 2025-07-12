{
  programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
      picker = {
        enabled = true;
        sources.explorer.layout.layout.position = "right";
      };
      explorer = {
        enabled = true;
      };
      bigfile = {
        enabled = true;
      };
      image = {
        enabled = true;
      };
    };
  };
}
