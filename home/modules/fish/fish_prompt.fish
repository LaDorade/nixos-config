set -l retc red
test $status = 0; and set retc green

set -q __fish_git_prompt_showupstream
or set -g __fish_git_prompt_showupstream auto

function _nim_prompt_wrapper
    set retc $argv[1]
    set -l field_name $argv[2]
    set -l field_value $argv[3]

    set_color normal
    set_color $retc
    echo -n '─'
    set_color -o green
    echo -n ' '
    set_color normal
    test -n $field_name
    and echo -n $field_name:
    set_color $retc
    echo -n $field_value
    set_color -o green
    echo -n ' '
end

set_color $retc
echo -n '┬─'
if test -n "$IN_NIX_SHELL" #if we are in a nix-shell (not nix shell!) 
    set_color -o red
    echo -n "<nix-shell>"
else 
  echo -n (prompt_login)
end
set_color -o green
echo -n ' '

if functions -q fish_is_root_user; and fish_is_root_user
    set_color -o red
else
    set_color -o yellow
end

if test -n "$SSH_CLIENT" # if we are in ssh
  echo -n $USER
  set_color -o white
  echo -n @
  set_color -o blue
  echo -n (prompt_hostname)
  set_color -o white
  echo -n :(prompt_pwd)
else
  set_color -o cyan
  echo -n (prompt_pwd)
  set_color -o green
  echo -n ' '
end

# Date
_nim_prompt_wrapper $retc '' (date +%X)

# Vi-mode
# The default mode prompt would be prefixed, which ruins our alignment.
function fish_mode_prompt
end

if test "$fish_key_bindings" = fish_vi_key_bindings
    or test "$fish_key_bindings" = fish_hybrid_key_bindings
    set -l mode
    switch $fish_bind_mode
        case default
            set mode (set_color --bold red)N
        case insert
            set mode (set_color --bold green)I
        case replace_one
            set mode (set_color --bold green)R
            echo '[R]'
        case replace
            set mode (set_color --bold cyan)R
        case visual
            set mode (set_color --bold magenta)V
    end
    set mode $mode(set_color normal)
    _nim_prompt_wrapper $retc '' $mode
end

# Virtual Environment
set -q VIRTUAL_ENV_DISABLE_PROMPT
or set -g VIRTUAL_ENV_DISABLE_PROMPT true
set -q VIRTUAL_ENV
and _nim_prompt_wrapper $retc V (path basename "$VIRTUAL_ENV")

# git
set -l prompt_git (fish_git_prompt '%s')
test -n "$prompt_git"
and _nim_prompt_wrapper $retc G $prompt_git

# Battery status
# type -q acpi
# and acpi -a 2>/dev/null | string match -rq off
# and _nim_prompt_wrapper $retc B (acpi -b | cut -d' ' -f 4-)
# type -q ioreg
# and ioreg -n AppleSmartBattery -r | awk '$1~/Capacity/{c[$1]=$3} \
# END{OFMT="%.2f%%"; max=c["\"MaxCapacity\""]; \
# print (max>0? 100*c["\"CurrentCapacity\""]/max: "?")}'
# and ioreg -n AppleSmartBattery -r | awk '$1~/ExternalConnected/{gsub("Yes", "+");gsub("No", "%"); print substr($0, length, 1)}'

if type -q ioreg
    set has_battery (ioreg -n AppleSmartBattery -r | awk -F'= ' '/"BatteryInstalled"/ {print $2}' | tr -d ' ')
    if test "$has_battery" = "Yes"
        set_color -o $retc
        echo -n '─ '
        set_color normal
        set current_capacity (ioreg -n AppleSmartBattery -r | awk -F'= ' '/"CurrentCapacity"/ {print $2}' | tr -d ' ')
        set max_capacity (ioreg -n AppleSmartBattery -r | awk -F'= ' '/"MaxCapacity"/ {print $2}' | tr -d ' ')
        set percent $current_capacity
        set charging (ioreg -n AppleSmartBattery -r | awk -F'= ' '/"ExternalConnected"/ {print $2}' | tr -d ' ')
        set symbol (test "$charging" = "Yes"; and echo "+"; or echo "%")
        set_color -o yellow
        echo -n "$percent"
        set_color normal
        echo -n "$symbol"
    end
end
# New line
echo

# Background jobs
set_color normal

for job in (jobs)
    set_color $retc
    echo -n '│ '
    set_color brown
    echo $job
end

set_color normal
set_color $retc
echo -n '╰─>'
set_color -o yellow
echo -n '$ '
set_color normal
# end
