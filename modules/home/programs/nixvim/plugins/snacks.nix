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
        doc = {
          max_width = 20;
          max_height = 10;
        };
      };
    };
  };
}
