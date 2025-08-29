{flake = self: let
  pkgs = flakeinputs.julia.activated;
in {
  devShells = {
    default = pkgs.mkShell ({
      packages = [pkgs.julia];
      RUBYLIB = "${pkgs.julia}/bin";
    });
  };
};