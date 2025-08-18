{ description = "Scafi Development Environment";
  inputs =
    { caffi = builtins.fetchGit {
      url = "/home/randa/AutoDev/src/test/space/scafi";
      rev = "HEAD"; 
    };
  }
  , outputs = [ pkgs ];

let
  flake = rec {
    inherit (pkgs) nix-develop;
  };
in

flake