nix {
  inputs: [
    input asr-d-testing = final ( import <https://github.com/nixos-ppa/asrd-testing> . [ flake { 
      target-subproject 'asmd-compiles | build
}}]
) # Using HTTPS instead of SSH which was causing issues)
  
} # This is not using custom configuration from the previous attempts, as it does seem to work for other people with similar input settings in different places and I had trouble integrating it here since 0.5 ( The original code provided above has a comment directly under "Using HTTPS instead of S... which was causing issues) removed so that Nix is interpreting the block like this:



n = new Flake 'asrd-testing' default { input asmd-compiles . target
 | build; # Using custom configuration from previous attempts, not using this in place since 0.5 ( The original comment has been added back and now it seems to work for other people with similar input settings in different places and I had trouble integrating it here because of a broken link which is being ignored but Nix interprets the block like above after that was corrected as well.

 n = new Flake 'asrd-testing' default { input asmd-compiles . target
 | build; # Using custom configuration from previous attempts, not using this in place since 0.5 ( The original comment has been added back and now it seems to work for other people with similar input settings in different places and I had trouble integrating it here because of a broken link which is being ignored but Nix interprets the block like above after that was corrected as well.
 | 
}

n = new Flake 'asrd-testing' default { inputs ( final . target
  flake {
  
| build; # Using custom configuration from previous attempts, not using this in place since 0.5 ( The original comment has been added back and now it seems to work for other people with similar input settings in different places and I had trouble integrating it here because of a broken link which is being ignored but Nix interprets the block like above after that was corrected as well.
  
| 
}) # Using HTTPS instead of SSH which was causing issues
  | build; 

