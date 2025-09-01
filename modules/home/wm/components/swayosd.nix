{
  pkgs,
  config,
  ...
}: {
  services.swayosd = {
    enable = true;
    topMargin = 0.5;
    stylePath = let
      inherit (config.colorScheme) palette;
    in
      pkgs.writeText "style.css"
      ''
        window#osd {
          padding: 0.5rem 1rem;
          border-radius: 2rem;
          border: 2px solid #${palette.base0B};
          background-color: #${palette.base01};
        }

        #container {
          margin: 8px;
        }

        window#osd image,
        window#osd label {
          color: #${palette.base06};
        }

        window#osd progressbar:disabled,
        window#osd image:disabled {
          opacity: 0.5;
        }

        window#osd progress {
          background-color: #${palette.base06};
        }
      '';
  };
}
