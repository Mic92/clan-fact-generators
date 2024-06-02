{ pkgs, lib, ... }:
with lib;
{

  ssh = { service ? "ssh", name ? "" }:
    let
      prefix = generatePrefix service name;
    in
    {
      secret."${prefix}.id_ed25519" = { };
      public."${prefix}.id_ed25519.pub" = { };
      generator.path = with pkgs; [ coreutils openssh ];
      generator.script = ''
        ssh-keygen -t ed25519 -N "" -f $secrets/${prefix}.id_ed25519
        mv $secrets/${prefix}.id_ed25519.pub $facts/${prefix}.id_ed25519.pub
      '';
    };

}
