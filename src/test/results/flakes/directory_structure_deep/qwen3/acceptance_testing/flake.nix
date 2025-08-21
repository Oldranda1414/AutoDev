

{
  description = "Development environment for acceptance_testing project";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/7e400f445b05e1183aaf02bc1846995d94313ef1";

  outputs = { self, nixpkgs }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      scala = pkgs.scalaPackage;
      sbt = pkgs.sbt_1_8_1;
    in
    {
      devShells.x86_64-linux = {
        system = "x86_64-linux";
        buildInputs = [ sbt ];
        nativeBuildInputs = [ scala ];
        shellHook = ''
          export PATH="$HOME/.sbt/boot:$PATH"
          export PATH="$HOME/.local/bin:$PATH"
        '';
      };
    };