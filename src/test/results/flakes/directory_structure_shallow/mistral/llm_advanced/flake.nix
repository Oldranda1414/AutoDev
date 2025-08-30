 nix
{ stdenv, nix-build, java, scala }

describe llmAdvanced as {
  src = ./.

  buildInputs = [ java scala ];
};
