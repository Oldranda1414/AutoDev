 
{ stdenv, nix-prelude }:

stdenv.makeBuildEnv {
  name = "llm_advanced";
  src = ./;

  buildInputs = [
    git
    nix-heredoc
  ];

  phases = phase {
    prebuild = () -> {
      self: stdenv.BuildEnv =>
      let
        gitDir = self.out.gitDir;
        gitCleanArgs = ["clean", "-f", "-d"];
      in
      if git.currentBranch gitDir != "master"; then
        git.execArgs gitDir "${gitCleanArgs[@]}";
      end;
    };
  };
}
