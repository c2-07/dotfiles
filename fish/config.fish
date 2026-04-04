# ENV + PATH

set -gx homebrew_no_env_hints 1
set -gx cflags "-std=c99 -wall -werror"
set -gx virtual_env_disable_prompt 1
set -gx cargo_target_dir "$home/.cargo-target"
set -gx editor nvim

# NEVER call npm here
set -gx path ~/.npm-global/bin $path

function __safe_add_path
    for p in $argv
        if test -d $p
            set -g path $p $path
        end
    end
end

function __safe_alias
    if type -q $argv[2]
        alias $argv[1]="$argv[2]"
    end
end


# Binary Path (Slow)
# __safe_add_path ~/.local/bin
# __safe_add_path /opt/homebrew/bin
# __safe_add_path ~/.rustup/toolchains/stable-aarch64-apple-darwin/bin


# Binary Path (Fast)
set -gx PATH \
    ~/.npm-global/bin \
    ~/.local/bin \
    /opt/homebrew/bin \
    ~/.rustup/toolchains/stable-aarch64-apple-darwin/bin \
    $PATH

set -gx PATH (string split ':' $PATH | awk '!seen[$0]++')


function __init_nix --on-event fish_postexec
    functions -e __init_nix

    if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    end
end


function __init_starship --on-event fish_prompt
    functions -e __init_starship

    if type -q starship
        starship init fish | source
    end
end


function z
    functions -e z

    if type -q zoxide
        zoxide init fish | source
        z $argv
    else
        echo "zoxide not installed"
    end
end


function __init_direnv --on-event fish_preexec
    functions -e __init_direnv

    if type -q direnv
        direnv hook fish | source
    end
end


function fish_greeting
    status --is-interactive; or return

    if not set -q __nanofetch_ran
        set -g __nanofetch_ran 1

        if test -x ~/.local/bin/nanofetch
            command ~/.local/bin/nanofetch
        end
    end
end


alias reload="source ~/.config/fish/config.fish"
alias vi=nvim

if type -q eza
    alias ls='eza -l --group-directories-first --no-user --no-time'
else
    alias ls="ls -lah"
end

if type -q bat
    alias cat="bat -p"
end

alias g=git
alias gs="git status"
alias gc="git commit -m"
alias gp="git push"

alias ..="cd .."
alias ...="cd ../.."

function backup --argument file
    if test -f "$file"
        cp "$file" "$file.bak"
    else
        echo "file not found: $file"
    end
end

function copy
    set count (count $argv)

    if test "$count" -eq 2; and test -d "$argv[1]"
        command cp -r "$argv[1]" "$argv[2]"
    else
        command cp $argv
    end
end

function r --description "compile and run source files"
    if test (count $argv) -ne 1
        echo "usage: r <source-file>"
        return 1
    end

    set file $argv[1]

    if not test -f "$file"
        echo "file not found: $file"
        return 1
    end

    set parts (string split -r -m1 . "$file")
    if test (count $parts) -ne 2
        echo "invalid filename"
        return 1
    end

    set name $parts[1]
    set ext  $parts[2]

    switch $ext
        case c
            clang "$file" -std=c11 -Wall -Wextra -O2 -o "$name"; or return
            ./"$name"; set code $status; rm -f "$name"; return $code

        case cpp cc cxx
            clang++ "$file" -std=c++20 -Wall -Wextra -O2 -o "$name"; or return
            ./"$name"; set code $status; rm -f "$name"; return $code

        case rs
            rustc "$file" -C opt-level=2 -o "$name"; or return
            ./"$name"; set code $status; rm -f "$name"; return $code

        case go
            go run "$file"
            return $status

        case java
            javac "$file"; or return
            java "$name"; set code $status; rm -f "$name.class"; return $code

        case zig
            zig run "$file"
            return $status

        case asm s
            nasm -f elf64 "$file" -o "$name.o"; or return
            ld "$name.o" -o "$name"; or return
            ./"$name"; set code $status; rm -f "$name.o" "$name"; return $code

        case '*'
            echo "unsupported language: .$ext"
            return 1
    end
end

if test (uname) = darwin
    function develop --description "init nix flake + direnv"
        set template devshell
        set dir .

        switch (count $argv)
            case 1
                set template $argv[1]
            case 2
                set dir $argv[1]
                set template $argv[2]
        end

        if not test -d "$dir"
            echo "directory '$dir' does not exist"
            return 1
        end

        pushd "$dir" >/dev/null

        if test -e flake.nix
            echo "flake.nix already exists — aborting"
            popd >/dev/null
            return 1
        end

        nix flake init -t github:integralcat/nix-templates#$template

        if not test -e .envrc
            echo "use flake" > .envrc
            direnv allow
        else
            echo ".envrc already exists — not touching it"
        end

        popd >/dev/null
    end
end
