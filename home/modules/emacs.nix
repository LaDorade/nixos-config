{
pkgs,
lib,
config,
...
}:
{
	options = {
		emacs = {
			enable = lib.mkEnableOption "Install Emacs";
		};
	};

	config = {
		programs.emacs = lib.mkIf config.emacs.enable {
			enable = true;
		};
	};
}
