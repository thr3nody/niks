{ config, ... }:

{
  programs.wofi = {
    enable = true;
    style = let
      inherit (config.colorScheme) palette;
    in
    ''
      * {
        border-radius: 10px;
      }

      #window {
        background-color: #${palette.base02};
        padding: 1em;
      }

      #input {
        backgound-color: #${palette.base03}:
        color: #${palette.base07}:
        margin-bottom: 0.5em;
        border-color: #${palette.base09};
      }
    '';
  };
}
