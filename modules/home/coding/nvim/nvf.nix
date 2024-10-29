_: {
  imports = [
    ./nvf.nix
    ./visuals.nix
    ./theme.nix
    ./filetree.nix
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        autoIndent = true;
        autocomplete.enable = true;
        autopairs.enable = true;

        treesitter = {
          enable = true;
          addDefaultGrammars = true;
          context.enable = true;
          highlight.enable = true;
          autotagHtml = true;
        };

        telescope = {
          enable = true;
        };

        comments.comment-nvim = {
          enable = true;
        };

        dashboard = {
          startify.enable = true;
        };
      };
    };
  };
}
