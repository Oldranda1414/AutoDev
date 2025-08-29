

{
  inputs = {
    julia = {
      url = "github:julialang/julia";
      flakeActivation = false;
    };
  };
  outputs = { self, julia }@args: {
    devShell = pkgs.stdenv.shell;
    devShell.inputs = {
      julia = julia;
    };
  };
}