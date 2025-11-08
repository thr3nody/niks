{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    prog.bash.fishAsInteractiveShell = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables fish as an interactive shell through bash.";
    };
  };

  config = lib.mkIf config.prog.bash.fishAsInteractiveShell {
    programs.bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  };
}
