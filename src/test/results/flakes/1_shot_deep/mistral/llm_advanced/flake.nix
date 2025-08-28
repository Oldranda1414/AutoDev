 nix
{ stdenv, nix-prefabs, git }

# Flake configuration
name = "my-project";
description = "Description of my project.";

# Dependencies
inputs.space = {
  url = "git+https://github.com/randa/AutoDev.git";
  rev = "master";
}

# Outputs
outputs = { self, space }: {
  inherit (stdenv.library path)
  pkgs = stdenv.mkDerivation rec {
    name = "${name}.build";
    src = newDir "/build";
    buildInputs = [ space.space ];
  };
}
