{lib, ...}: let
  # 1. Recursive scanner
  recurse = path: let
    # readDir returns a set { "filename" = "regular"; "dirname" = "directory"; ... }
    files = builtins.readDir path;

    # Helper to decide what to do with each file/dir
    process = name: type: let
      fullPath = path + "/${name}";
    in
      # A. Directory Handling
      if type == "directory"
      then let
        defaultFile = fullPath + "/default.nix";
        # If default.nix exists, treat dir name as module name
        current =
          if builtins.pathExists defaultFile
          then [(mkModule name defaultFile)]
          else [];
        # Always recurse deeper
        children = recurse fullPath;
      in
        current ++ children
      # B. Nix File Handling (ignore default.nix as it's handled above)
      else if type == "regular" && name != "default.nix" && lib.hasSuffix ".nix" name
      then let
        moduleName = lib.removeSuffix ".nix" name;
      in [(mkModule moduleName fullPath)]
      # C. Ignore non-nix files
      else [];
  in
    # Flatten the results of the map
    lib.flatten (lib.mapAttrsToList process files);

  # 2. Module Generator
  mkModule = name: path: {
    config,
    lib,
    pkgs,
    ...
  } @ args: {
    options.modules = {
      ${name} = lib.mkEnableOption "Enable ${name}";
    };

    # The Optimization: Import once, check type, apply.
    config = lib.mkIf config.modules.${name} (
      let
        # Import the file *once*
        module = import path;
      in
        # If the imported file is a function (e.g. { pkgs, ... }: ...),
        # call it with the current args. Otherwise use it directly.
        if builtins.isFunction module
        then module args
        else module
    );
  };
in {
  imports = recurse ./.;
}
