nix
{
  deps := ["http: https://docs.nixpkgs.org/en/latest-nixpkgs/assets/logo.png"];

  inputs :=
    mapLiterals [
      nixpkgs
      ]
    ;

    outputs := {
        outputA := "https://github.com/nixpkgs/nixpkgs/releases";
        outputB := "http://gitlab.nixcraft.net/nixcraft";
    };
} | mapLiterals [
  nix,
  inputs,
  outputs,
  {
    deps := ["https://github.com/nixpkgs/nixpkgs/releases"];
    outputs := {
      outputA := "https://docs.nixpkgs.org";
      outputB := "https://docs.nixpkgs-community.org";
    };
  }
];
