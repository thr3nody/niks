{
  lib,
  config,
  ...
}: {
  options = {
    progs.ssh.autoStartAgent = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Autostart ssh-agent on boot.";
    };
  };

  config = lib.mkIf config.progs.ssh.autoStartAgent {
    programs.ssh.startAgent = true;
  };
}
