{ description = "Integration Testing";

inputs = {
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/32f313e49e42f715491e1ea7b306a87c16fe0388";
    sha256 = "0v4jw5hcv9f9x6qyp5kyl3h2n8j6p1fls3n9z5r25vzr0v5i8";
  };
};

system = { config, pkgs, ... } @ inputs:

let
  shell = pkgs.mkShell {
    name = "integration-testing";
    buildInputs = [ pkgs.sbt ];
  };
in

{ devShell = shell; }