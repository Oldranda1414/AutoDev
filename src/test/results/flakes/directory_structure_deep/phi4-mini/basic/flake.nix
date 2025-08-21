nix
{
  description = "Development environment for a Julia project";

  sourceCompatibility = false;
  
  outputshell.packages = [
    pkgs.julialang@1.5,
    pkgs.nvim,
    pkgs.vim,
    (pkgs.lib.mkIf { enablePkglibsOverride = true })
      {
        myLibs = import ./path/to/your/library/nix/stable;
      }
  ];

  devShellHooks = [mkShellHook "my-command" ""]

  devshell.default = mkShell {
    buildInputs = [
      pkgs.julialang@1.5
      pkgs.vim
      (pkgs.lib.mkIf { enablePkglibsOverride = true })
        myLibs.withDefaultSource path/to/your/library/nix/stable
    ];
  };

  inherit sources.urlConfig.defaultGitSource;
}
