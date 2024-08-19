{
  description = "Basic flake for multisystem nixpkgs";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        gems = pkgs.bundlerEnv {
          name = "pedagogue-gems";
          gemdir = ./.;
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.bundler pkgs.bundix gems gems.wrappedRuby ];
        };
      });
}
