{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "frode.egeland";
  home.homeDirectory = "/Users/frode.egeland";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    awsume
    awscli2
    bat
    dbeaver-bin
    delta
    deno
    docker
    fzf
    gnused
    gron
    jq
    lsd
    nodejs_22
    pwgen
    ripgrep
    starship
    tree
    wget
    zoxide
    lazygit
    

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/frode.egeland/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
  };
  programs.starship = {
      enable = true;
      settings = {
        sudo = {
          disabled = false;
        };
      };
  };
  programs.zoxide.enableZshIntegration = true;
  programs.zsh = {
  	enable = true;
    autosuggestion.enable = true;
  	history = {
  		ignoreAllDups = true;
  	};
  	shellAliases = {
		ll = "lsd -lh";
		la = "lsd -lha";
    gst = "git status";
    awsume = "source awsume";
	};
	initExtra = "eval \"$(zoxide init --cmd c zsh)\"\n
    fpath=(~/.awsume/zsh-autocomplete/ $fpath)
    PATH=$HOME/.cargo/bin:/opt/homebrew/opt/node@22/bin:$PATH";
  };
  programs.fzf = {
  	enable = true;
  };
  programs.git = {
    enable = true;
    userName = "Frode Egeland";
    userEmail = "frode.egeland@amaysim.com.au";
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJVi/oMY1pAdioLmEkqzCexFono9ZuI7coltigGreKA/";
      signByDefault = true;
    };
    delta.enable = true;
    aliases = {
      ci = "commit --signoff";
      prp = "pull --rebase --prune";
      lg = "log --oneline --abbrev-commit --all --graph --decorate --color --show-signature --no-merges";
      cb = "checkout -b";
      co = "checkout";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
