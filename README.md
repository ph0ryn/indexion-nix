# indexion-nix

Nix package for the official [indexion](https://github.com/trkbt10/indexion) release binaries.

## Usage

### Run

```sh
nix run github:ph0ryn/indexion-nix -- --help
```

### Install

```nix
# flake.nix
inputs.indexion-nix = {
  url = "github:ph0ryn/indexion-nix";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

```nix
{
  nixpkgs.overlays = [ inputs.indexion-nix.overlays.default ];
  environment.systemPackages = [ pkgs.indexion ];
}
```

For Home Manager, use `home.packages = [ pkgs.indexion ];` instead.
