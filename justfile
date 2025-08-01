alias c := check
alias n := nix

type := if os() == "macos" { 'darwin' } else { 'os' }

check:
    nix flake check

nix cmd='switch':
    nh {{ type }} {{ cmd }} .