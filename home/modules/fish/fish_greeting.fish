# function fish_greeting
#     if not set -q fish_greeting
#         set -l line1 (_ 'Welcome to fish, the friendly interactive shell')
#         set -l line2 \n(printf (_ 'Type %shelp%s for instructions on how to use fish') (set_color green) (set_color normal))
#         set -g fish_greeting "$line1$line2"
#     end

#     if set -q fish_private_mode
#         set -l line (_ "fish is running in private mode, history will not be persisted.")
#         if set -q fish_greeting[1]
#             set -g fish_greeting $fish_greeting\n$line
#         else
#             set -g fish_greeting $line
#         end
#     end

#     # The greeting used to be skipped when fish_greeting was empty (not just undefined)
#     # Keep it that way to not print superfluous newlines on old configuration
#     test -n "$fish_greeting"
#     and echo $fish_greeting
# end

# function fish_greeting
# Salutations maritimes
set -l greetings \
    "🌊 Ahoy, sailor! The shell seas are calm today." \
    "⚓ Welcome aboard, matey! Chart your course with confidence." \
    "🐚 The tide is right for shell commands. Let's dive in!" \
    "🦑 Ready your gear — deep shell diving begins now." \
    "🚢 Full speed ahead, captain! May your commands be swift." \
    "🧭 You've entered uncharted waters. Type wisely!" \
    "🐠 Fish reporting for duty. Let’s make waves in the terminal." \
    "🪝 Hook your next command — the ocean is full of possibilities."

# Choisir un message aléatoire
set -l random_index (math (random) % (count $greetings) + 1)
set -l line1 $greetings[$random_index]

# Message d’aide
set -l line2 \n(printf 'Type %shelp%s to consult the captain’s log.' (set_color cyan) (set_color normal))

# Mode privé
set -l private_msg ""
if set -q fish_private_mode
    set private_msg \n(set_color yellow)"🔒 Sailing incognito: history will not be logged in this voyage."(set_color normal)
end

echo $line1$line2$private_msg
