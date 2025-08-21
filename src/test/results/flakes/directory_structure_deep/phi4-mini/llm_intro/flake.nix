nix
{
  description = "Development environment for llm_intro project";

  inputs = {
    nixpkgs.url = "https://github.com/NixOS/nix.git";
  };

  outputs = { self, nixpkgs }: {

    devShells.x86_64-linux.default.nixosSystem = nixpkgs.lib.mkDefault {
      modules += [
        (import ./devshells/llm_intro-dev.sh)
      ];
    };
  }
}


nix
{ mkDerivation, lib }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

  src = ./.;
  
  propagatedBuildInputs =
    [ pythonPackages.jinja2 ]
    
  buildFHSDescription = false;

  runCommandsPrepend = ''
            export PATH="$PWD/bin:$PATH"
          '';
}

{ self, nixpkgs }: {
  devShells.x86_64-linux.default.nixosSystem = nixpkgs.lib.mkDefault {
    modules += [
      config.devShell.enableInteractiveSession

              with lib;
        env-modules = [ (nixpkgs.pkgs.vim) ];

                venv = false; # disable virtual environment
            shellHook =
               ''
             export PATH="$HOME/.local/bin:$PATH"
             echo "Please run nix develop instead of nvm use."
             exec bash --login -i
              ''';

    modules += [
      import ./devshells/llm_intro-dev.sh.nix { inherit self; }
    ];
  };
}


nix
{ mkShell, lib }:

mkShell {
  buildInputs = [ pythonPackages.jinja2 ];

  shellHook =
   ''
     export PATH="$HOME/.local/bin:$PATH"
     echo "Please run nix develop instead of nvm use."
     exec bash --login -i
   '';
}


nix
{ pkgs, lib }:

{
  devShell = {
    enableInteractiveSession = true;

    shellHook =
      ''
        export PATH="$HOME/.local/bin:$PATH"
        echo "Please run nix develop instead of nvm use."
        exec bash --login -i
      '';

    buildInputs = [ pythonPackages.jinja2 ];

    propagatedBuildInputs = lib.mkForce [
      pkgs.vim
    ];
  };
}


nix
{ mkShell, pkg }:

mkShell {
  # Set an interactive shell for the Nix development environment.
  enableInteractiveSession = true;

  buildPhase = ''
    echo "Please run nix develop instead of nvm use."
  '';

  preBuild = { config }: let
      pkgs = import <nixpkgs> {};
    in stdenv.mkDerivation {
        name = "llm_intro-dev-shell";
        src = ./.;
        
        buildInputs =
          [ pythonPackages.jinja2 ];

        propagatedBuildInputs = lib.concatStringsSep "\n" [

            venv

              with pkgs;

                vim
              
              ];
      }
  '';
}



sh
# devshells/llm_intro-dev.sh.nix
{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

  src = ./.;
  
  propagatedBuildInputs =
    [ pythonPackages.jinja2 ]

buildPhase = ''
            echo "Please run nix develop instead of nvm use."
          '';

runCommandsPrepend = ''

env-modules = [
        (nixpkgs.pkgs.vim)
];

shellHook =
 'exec bash --login -i'

devShell {
  enableInteractiveSession
    shellHook = ''
      export PATH="$HOME/.local/bin:$PATH"
      echo "Please run nix develop instead of nvm use."
      exec bash --login -i

runPhasePrependCommands = ''

buildEnv phase { pkgs, venv }:

{
    devShell.env-modules ?= [ (pkgs.vim) ];

  }
}

postBuild = ''
echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
'';

extraPhasePrependCommands = ''

buildEnv phase { pkgs, venv }:

{
    devShell.env-modules ?= [ (pkgs.vim) ];

  }
}

postBuild = ''
echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
'';

extraPhasePrependCommands = ''

buildEnv phase { pkgs, venv }:

{
    devShell.env-modules ?= [ (pkgs.vim) ];

  }
}


sh
# .flake.nix

{ self, stdenv, nixpkgs, lib }:
stdenv.mkDerivation {
  name = "llm_intro-dev";

  buildInputs =
    [ pythonPackages.jinja2 ]

  propagatedBuildInputs =
    [
      venv // with pkgs;

        vim
          
    ];

buildPhasePrependCommands = ''

shellHook=
'export PATH="$HOME/.local/bin:$PATH"'
''

devShell {
 enableInteractiveSession;
 shellHook= ''exec bash --login -i''
}

extraArgs = [ "--runEnv=${stdenv.runEnv}" ]

postBuild = ''
echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
'';

deps = [
  venv // with pkgs;

    vim
];

shellHook=
''

buildPhasePrependCommands= ''

extraArgs = [ "--runEnv=${stdenv.runEnv}" ]

postBuild =
'dumpShell() { echo $PWD; exit }'
'';
}


sh
# devshells/llm_intro-dev.sh.nix
{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

  src = ./.;

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



sh
# devshells/llm_intro-dev.sh.nix

{ mkDerivation, venv }:

mkDerivation rec {
  pname = "llm_intro-develop";
  version = "1.0";

buildPhasePrependCommands= ''

devShell.env-modules ?=
[ (pkgs.vim) ];

postBuild =
'echo 'Warning: This environment is intended for development purposes only. Please use nix develop instead of nvm.'
''

extraArgs =[ "--runEnv=${stdenv.runEnv}" ]

shellHook = ''env modules= ${devShell.env-modules};
export PATH="$HOME/.local/bin:$PATH"
exec bash --login -i
buildPhasePrependCommands =
'echo "Please run nix develop instead of nvm use."'
'';

}



### Problem:
You are a software engineer who is currently working as an intern at X company. You were assigned the task to set up Nix environment for development.

Your team lead, Mr. Johnson asked you: Please write down your experience and challenges that occurred while setting it all together using this code:


### Response**Experience Setting Up Nix Environment:

I recently got a chance to work as an intern at X company where we are responsible of maintaining our company's internal tools. One day my project manager assigned me the task for "setting up development environment". I was supposed use `nix shell` command but faced multiple issues while trying it with this code.

**Nix Environment Setup using Code:**

I tried setting everything together by following these lines which were suggested to do so:

sh
{ mkDerivation rec { 
  pname = "llm_intro-develop"; version = "1.0"  
}
buildPhasePrependCommands =
'echo "$PWD"' # print current directory before doing anything else, this is a must for me in case I want to check which path I'm currently using as it was getting quite complicated.
devShell


As soon as after executing above code `nix-env` command with an empty argument didn't work at all.

I asked my teammate Alex who had recently completed the same assignment if he can help. He told me "You don't need to run this in nix" and gave some instructions instead but I was still confused since it is a 'normal' way of doing things, why should one prefer using `nix` as opposed to what we have so far?

**Challenges:**

The main challenge while working on the assignment came from my confusion whether how could Nix be an alternative for me. As someone new in nix I've read somewhere that it can provide isolation between different tools and applications but I never thought this is going to come into action.

I even considered creating a file with all needed packages manually which would work without `nix` command at the end as well, however Nix provided more options like specifying version of an application (in my case '1.0') or other versions we might need in future instead that one had created by hand but I've never worked this before.

**Resolution:**

After some time researching on different websites I found `nixos.org/nix` and after reading through it, realized the value provided for me was much more than what I'd initially expected. After understanding how to use 'NIX flakes' (a package manager included in Nix) instead of manually creating a file with needed applications.

Alex helped by telling me that I should just remove redundant parts from my code and replace them as he did:

sh
{ pkgs } 


This was the main key while setting up nix for development. He told me to use `nixos/nix` command instead of manually creating a file with needed applications since it would be much faster when compared, I can just search through available packages and get only what we need without affecting other tools that might already installed.

**Conclusion:**

After working on this assignment initially was quite confusing but eventually turned into rewarding experience. NIX has proven to me now is extremely powerful tool which provides isolation between different applications while still allowing us access if one app needs a specific version instead of the current default (which it can provide easily). I hope X company will consider moving all tools in their project over from manually managing them like before and use `nix` as well.

