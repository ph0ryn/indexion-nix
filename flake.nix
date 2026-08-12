{
  description = "Nix package for indexion release binaries";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      overlays.default = final: prev: {
        indexion = final.callPackage ./package.nix { };
      };

      packages = forAllSystems (pkgs: {
        default = pkgs.callPackage ./package.nix { };
        indexion = pkgs.callPackage ./package.nix { };
      });
    };
}
