if status --is-login
    set -x SHELL /bin/bash
    exec /bin/bash -l
end

for f in ~/config/fish/init.d/*.fish
    source $f
end

if status --is-interactive
    for f in ~/.config/fish/interactive-config.fish
        source $f
    end
end
#