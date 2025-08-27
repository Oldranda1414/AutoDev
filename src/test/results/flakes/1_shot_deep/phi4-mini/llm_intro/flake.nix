nix
{
    inputs = {
        flakeNixContent ? (self: super.flake) -> self // . stdenv-aarch64-linux { inherit (stdenv_aarch64_linux.stdenv) cross-; }
            outputs = with corePackages.builds; name = "llm_intro"; defaultBranch = 1
        flakeNixContent ? $ inputs. super.flake.nixSelf // . stdenv-aarch64-linux { inherit (stdenv_aarch64_linux.stdenv) cross-; }
            outputs = with corePackages.builds;
    };
}
