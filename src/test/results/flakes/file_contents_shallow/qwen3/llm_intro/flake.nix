

nix
{
  description = "Development environment for llm_intro project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    scalaPlatform.url = "github:scalac/scala-platform";
  };

  outputs = { self, nixpkgs, scalaPlatform }:
    let
      scalaVersion = "3.3.5";
      sbtVersion = "1.10.7";
      devShell = {
        nativeBuildInputs = [ nixpkgs.stdenv.cc ];
        buildInputs = [
          nixpkgs.java-17-openjdk
          nixpkgs.git
          nixpkgs.zlib
          nixpkgs.llvm_16
          nixpkgs.llvm_16_dev
          nixpkgs.llvm_16_utils
          nixpkgs.llvm_16_debugserver
          nixpkgs.llvm_16_profiler
          nixpkgs.llvm_16_omp
          nixpkgs.llvm_16_lto
          nixpkgs.llvm_16_sanitizers
          nixpkgs.llvm_16_coverage
          nixpkgs.llvm_16_debuginfo
          nixpkgs.llvm_16_plugins
          nixpkgs.llvm_16_toolchain
        ];
        shellHook = ''
          export PATH=$PATH:$HOME/.local/bin
          export JAVA_HOME=$(readlink -f /usr/bin/java | sed -e 's:/bin/java::')
          export PATH=$JAVA_HOME/bin:$PATH
        '';
        cargoBuildTarget = "llm_intro";
        cargoFeatures = [ "default" ];
        cargoBuildOptions = [ "--release" ];
      };
    in
    {
      devShell = devShell;
      defaultShell = devShell;
      packages.x86_64-linux = {
        devShell = devShell;
      };
    }
}
