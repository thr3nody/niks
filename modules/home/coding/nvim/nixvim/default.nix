{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.default

    ./options.nix
  ];

  programs.nixvim.enable = true;
}
