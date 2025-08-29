nixos
{
  inputs = { pkgs, ... }:

    outputs = { self, pkgs, ... }: {

      devShells.x86_64-linux = mkShell {
        buildInputs = with pkgs; [ "stack" ];

        shellHook = ''
          eval $(xargs nix-build -I${pkgs} --arg crossSystem x86_64 none
            /home/randa/AutoDev/src/test/space/acceptance_testing/dev.nix)
        '';
      };
    };

  devnixos = { ... }: with pkgs; {
    buildInputs = [ "stack" ];

    # Add any other necessary packages for your development environment here.
  }
}
