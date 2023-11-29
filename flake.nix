{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.janet2nix.url = "github:yzupnick/janet2nix";

  outputs = { self, nixpkgs, flake-utils, janet2nix }:
    flake-utils.lib.eachDefaultSystem (system:
    let 
      pkgs = import nixpkgs { inherit system; overlays = janet2nix.overlays.${system};};
    in {
      packages = {
        default = pkgs.mkJanetApplication {
            name = "test";
            src = ./.;
            withJanetPackages = [
              pkgs.janetPackages.spork
            ];
        };
      };

      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.janet
          pkgs.jpm
          (pkgs.writeShellApplication {
            name = "install-deps";
            runtimeInputs = [ pkgs.janetPackages.spork.package ];
            text = ''
              jpm install file://${pkgs.janetPackages.spork.package}/
            '';
          })
        ];
      };
   });
}
