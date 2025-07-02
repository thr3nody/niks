{
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
      v = "nvim";
      vh = "nvim .";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    functions = {
      rebuild = "nh os $argv -a -H default"; # sudo nixos-rebuild $argv --flake /home/erine/niks/#default --show-trace --verbose
      update = "nh os $argv -u -a -H default"; # nix flake update; sudo nixos-rebuild $argv --flake /home/erine/niks/#default --show-trace --verbose
      fuck = "nix shell nixpkgs#$argv";
      shit = "nh search $argv";
    };
  };
}
