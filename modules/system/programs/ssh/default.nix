{
  lib,
  config,
  ...
}: {
  options = {
    prog.ssh.autoStartAgent = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Autostart ssh-agent on boot.";
    };
  };

  config = lib.mkIf config.prog.ssh.autoStartAgent {
    programs.ssh.startAgent = true;
  };
}
