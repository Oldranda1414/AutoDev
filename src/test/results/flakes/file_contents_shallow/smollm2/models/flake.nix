
// nix-build
#!/usr/bin/env nix-shell --pure path=${NIX_PATH} -p ${HOME}/AutoDev/nixpkgs/channel:1.0 -A git
{
    pkgs = flake-pkgs;

    importGitRepository {
        url = "https://github.com/hackeo/course-asmd";
        branch = "master";
        rev = "42";
        name = "model";
        force = true;
    };
}
