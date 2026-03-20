{
pkgs,
lib,
config,
...
}:
let
	cfg = config.tmux;
in
{
	options = {
		tmux = {
			enable = lib.mkEnableOption "Use Tmux";
		};
	};
	config = lib.mkIf cfg.enable {
		programs.tmux = {
			enable = true;
			keyMode = "vi";
		};
	};
}
