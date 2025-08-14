alias c := check
alias n := nix

type := if os() == "macos" { 'darwin' } else { 'os' }

check:
    nix flake check

# exemple: just n test -a
nix *cmd='switch':
    nh {{ type }} {{ cmd }} .

test *args:
    just nix test {{args}}

switch *args:
    just nix switch {{args}}

boot *args:
    just nix boot {{args}}
