nixos
# flake.nix

{ pkgs ? (import <home/randa/AutoDev/src/test/space/models/configureFlakes.sh> : { nix { } })
    packages.{
      auto_model_test_configure_flakes = {
        inherit auto_models_1;
      }
    },
  configuration: null
}
