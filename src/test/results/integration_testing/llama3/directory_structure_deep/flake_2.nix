{ 
  description = "Integration testing environment";

  outputs = [ self ];
  inputs.nixpkgs = builtins.fetchTarball https://nixos.org/nix/nix-3.22.tar.gz;

  shell = project.sbtBuild "develop";
}