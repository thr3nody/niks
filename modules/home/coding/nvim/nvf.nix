{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./visuals.nix
    ./theme.nix
    ./filetree.nix
    ./visuals.nix
    ./languages.nix
  ];

  programs.nvf = {
    enable = true;
    enableManpages = true;

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

        dashboard = {
          startify.enable = true;
        };
      };
    };
  };
}
