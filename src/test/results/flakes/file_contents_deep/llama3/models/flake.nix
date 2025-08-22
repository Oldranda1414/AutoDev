package {
  inputs = ["u08/modelling" ];
  outputs = [ "flake.nix" ];

  function (flake : null){
    output Flake
      {
        name = "flake";
        type = "flakes"; 
      };

  };
}