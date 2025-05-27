{ config, pkgs, lib, ... }:

let name = "Steven Yin";
    user = "syin";
    email = "syin@groq.com"; in
{
  eza = {
    enable = true;
    enableZshIntegration = true;
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "nvim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    colorschemes.tokyonight.enable = true;
    opts = {
      number = true;
      ruler = true;
      cursorline = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      smartindent = true;
      backup = false;
      writebackup = false;
      swapfile = false;
      incsearch = true;
      ignorecase = true;
      hlsearch = true;
      termguicolors = true;
      clipboard = "unnamedplus";
    };
    keymaps = [
      {
        action = ":nohlsearch<Bar>:echo<CR>";
        key = "<silent><Space>";
        mode = "n";
      }
      {
        action = ":bnext<CR>";
        key = "<Tab>";
        mode = "n";
      }
      {
        action = ":bprevious<CR>";
        key = "<S-Tab>";
        mode = "n";
      }
    ];
    plugins = {
      lualine = {
        enable = true;
        settings = {
          tabline = {
            lualine_a = ["buffers"];
          };
        };
      };
      telescope = {
        enable = true;
        settings = {
          defaults = {
            file_ignore_patterns = [
              "^.git/"
            ];
            set_env.COLORTERM = "truecolor";
          };
        };
      };
      treesitter = {
        enable = true;
        nixvimInjections = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        folding = false;
      };
      web-devicons = {
        enable = true;
      };
    };
  };

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      ${user} = {
        hostname = "${user}";
        forwardAgent = true; 
        extraOptions = {
          RemoteCommand = "tmux -CC new -A -s session";
          RequestTTY = "force";
        };
      }; 
      sft = {
        match = "exec \"/usr/local/bin/sft resolve -q %h\"";
        proxyCommand = "/usr/local/bin/sft proxycommand %h";
        extraOptions = {
          userKnownHostsFile = "/Users/${user}/Library/Application Support/ScaleFT/proxycommand_known_hosts";
        };
      };
      "github.com" = {
        extraOptions = {
          addKeysToAgent = "yes"; 
        };
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_ed25519"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_ed25519"
          )
        ];
      };
    };
  };

  starship = {
    enable = true;
  };

  wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./config/wezterm.lua;
  };

  zsh = {
    enable = true;
    autocd = false;

    history.size = 10000;

    zplug = {
      enable = true;
      plugins = [
        { name = "Aloxaf/fzf-tab"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };

    initContent = lib.mkBefore ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # starship prompt
      eval "$(starship init zsh)"

      # Define variables for directories
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # neovim is my editor
      export ALTERNATE_EDITOR=""
      export EDITOR="nvim"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'

      # zoxide
      eval "$(zoxide init zsh --cmd cd)"
    '';
  };
}
