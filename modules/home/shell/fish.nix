_: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
      zoxide init fish | source
      set fish_greeting
      bunbun
    '';
    shellAliases = {
      blade = "GDK_BACKEND=x11 SDL_VIDEODRIVER=x11 nvidia-offload flowblade";
      g = "git";
      c = "code";
      ch = "code .";
      v = "lvim";
      vh = "lvim .";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    functions = {
      rebuild = "sudo nixos-rebuild $argv --upgrade --flake /home/erine/niks/#default --show-trace --verbose";
      fuck = "nix shell nixpkgs#$argv";
    };
  };
}
