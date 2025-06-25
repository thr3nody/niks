{
  programs.nixvim.plugins = {
    smear-cursor = {
      enable = true;
      settings = {
        stiffness = 0.5;
        trailing_stiffness = 0.5;
        damping = 0.67;
        matrix_pixel_threshold = 0.5;
      };
    };
    web-devicons.enable = true;
    noice.enable = true;
    notify = {
      enable = true;
      settings = {
        backgroundColour = "#32302F";
        level = "warn";
      };
    };
    gitsigns = {
      enable = true;
    };
    trouble.enable = true;
    indent-blankline.enable = true;
    colorizer.enable = true;
    lualine = {
      enable = true;
      settings = {
        options.disabled_filetypes.statusline = [
          "dashboard"
          "alpha"
          "neo-tree"
        ];
        alwaysDivideMiddle = true;
        globalstatus = true;
        ignoreFocus = ["neo-tree"];
        extensions = ["fzf"];
        theme = "auto";
        componentSeparators = {
          left = "|";
          right = "|";
        };
        sectionSeparators = {
          left = "█"; # 
          right = "█"; # 
        };
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch" "diff" "diagnostics"];
          lualine_c = ["filename"];
          lualine_x = ["filetype"];
          lualine_y = ["progress"];
          lualine_z = [''" " .. os.date("%R")''];
        };
      };
    };
  };
}
