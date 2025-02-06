{
  lib,
  pkgs,
  ...
}: {
  programs.nushell = {
    enable = true;
    extraConfig = ''
      def lla [...args] { ls -la ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
      def la  [...args] { ls -a  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
      def ll  [...args] { ls -l  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
      def l   [...args] { ls     ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }

      # NixOS rebuild with nh os rebuild.
      def rebuild [
        command: string = "switch"
        --hostname (-H): string = "default"
      ] {
          nh os $command -a -H $hostname
      }

      # Run nix shell in which the specified packages are available.
      def fuck [packages: string] {
        nix shell nixpkgs#($packages)
      }

      # Search NixOS packages with nh search.
      def shit [packages: string] {
        nh search $packages
      }

      let carapace_completer = {|spans: list<string>|
        carapace $spans.0 nushell ...$spans
        | from json
        | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
      }

      $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

      let zoxide_completer = {|spans|
          $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
      }

      let fish_completer = {|spans|
        ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
        | $"value(char tab)description(char newline)" + $in
        | from tsv --flexible --no-infer
      }

      let multiple_completers = {|spans|
        ## alias fixer start https://www.nushell.sh/cookbook/external_completers.html#alias-completions
        let expanded_alias = scope aliases
        | where name == $spans.0
        | get -i 0.expansion

        let spans = if $expanded_alias != null {
          $spans
          | skip 1
          | prepend ($expanded_alias | split row ' ' | take 1)
        } else {
          $spans
        }
        ## alias fixer end

        match $spans.0 {
          nu => $fish_completer
          git => $fish_completer
          __zoxide_z | __zoxide_zi => $zoxide_completer
          _ => $carapace_completer
        } | do $in $spans
      }

      $env.config = {
        show_banner: false
        edit_mode: "vi"
        completions: {
          case_sensitive: false
          quick: false
          partial: false
          algorithm: "prefix"
          external: {
            enable: true
            max_results: 50
            completer: $multiple_completers
          }
        }
        keybindings: [
          {
            name: move_up
            modifier: control
            keycode: char_k
            mode: [emacs, vi_normal, vi_insert]
            event: {
              until: [
                { send: menuup }
                { send: up }
              ]
            }
          }

          {
            name: move_down
            modifier: control
            keycode: char_j
            mode: [emacs, vi_normal, vi_insert]
            event: {
              until: [
                { send: menudown }
                { send: up }
              ]
            }
          }
        ]
      }

      $env.PATH = ($env.PATH |
        split row (char esep) |
        prepend /home/erine/.apps |
        append /usr/bin/env
      )

      bunbun
    '';
    shellAliases = {
      g = "git";
      c = "code";
      ch = "code .";
      v = "nvim";
      vh = "nvim .";
    };
  };
}
