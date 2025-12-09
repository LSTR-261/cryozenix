{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      alejandra
      nixfmt-rfc-style
      nixd
      markdown-oxide
      tinymist
      scooter
    ];
    settings = {
      editor = {
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        line-number = "relative";
        gutters = ["diff" "line-numbers" "spacer" "diagnostics"];
        indent-guides.render = true;
        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";
      };
      keys.normal = {
        C-r = [":wa" ":insert-output scooter --no-stdin >/dev/tty" ":redraw" ":rla"];
        C-g = [":wa" ":insert-output lazygit >/dev/tty" ":redraw" ":rla"];
        C-e = [":wa" ":insert-output yazi" ":bc!" ":redraw" ":rla"];
        C-s = [":wa"];
        space.q = ":q";
      };
      keys.insert.C-s = [":wa"];
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "alejandra";
        language-servers = ["nixd"];
      }
      {
        name = "markdown";
        auto-format = true;
        language-servers = ["markdown-oxide"];
        soft-wrap.enable = true;
        text-width = 80;
        soft-wrap.wrap-at-text-width = true;
      }
      {
        name = "typst";
        language-servers = ["tinymist"];
      }
    ];
  };
}
