# PATH — fish_add_path prepends, so later calls win.
# -g keeps paths session-scoped instead of persisting them in universal fish_user_paths.
/opt/homebrew/bin/brew shellenv fish | source
fish_add_path -g /usr/local/bin /opt/homebrew/opt/libpq/bin $HOME/.local/bin

# env
set -gx LANG en_US.UTF-8
set -gx EDITOR vim
ulimit -n 10000

# pennylane
if test -f ~/code/pennylane/jeancaisse/docker.env
    # parse export KEY=VALUE lines directly — no bash needed
    for line in (string match -r '^export .*' < ~/code/pennylane/jeancaisse/docker.env)
        set -l parts (string split -m 1 '=' (string replace 'export ' '' $line))
        set -gx $parts[1] (string trim -c '"\'' -- $parts[2])
    end
    set -gx DD_TRACE_ENABLED false
    fish_add_path -g \
        /opt/homebrew/opt/grep/libexec/gnubin \
        /opt/homebrew/opt/findutils/libexec/gnubin \
        /opt/homebrew/opt/gnu-sed/libexec/gnubin \
        /opt/homebrew/opt/coreutils/libexec/gnubin
end

# asdf shims last so they take priority over brew
fish_add_path -gm (set -q ASDF_DATA_DIR; and echo $ASDF_DATA_DIR; or echo $HOME/.asdf)/shims

status is-interactive; or return

# Source a tool's init script from cache; regenerate when the binary changes (e.g. brew upgrade).
function __oak_source_init --argument-names tool
    set -l bin (command -s $tool); or return
    set -l real (path resolve $bin)
    set -l cache $HOME/.cache/fish/oak-init-$tool.fish
    if not test -f $cache; or test "$(head -n1 $cache)" != "# $real"
        mkdir -p (path dirname $cache)
        begin
            echo "# $real"
            $argv[2..]
        end >$cache
    end
    source $cache
end

__oak_source_init fzf fzf --fish
__oak_source_init zoxide zoxide init --cmd j fish
__oak_source_init starship starship init fish --print-full-init
functions -e __oak_source_init

# ssh keychain (background, non-blocking)
ssh-add --apple-load-keychain >/dev/null 2>&1 &
disown 2>/dev/null

# aliases
alias reload! 'source ~/.config/fish/config.fish'
alias vi nvim
alias vim nvim
alias emacs 'open -a /Applications/Emacs.app'
alias ls 'eza -lh --group-directories-first --icons --hyperlink'
alias lsa 'ls -a'
alias lt 'eza --tree --level=2 --long --icons --git'
alias lta 'lt -a'
alias fvi 'vim (fzf --preview="bat --color=always {}")'
alias cat bat
alias git-clean 'git fetch -p; and git branch -vv | grep \': gone]\' | awk \'{print $1}\' | xargs git branch -D 2>/dev/null; or echo \'No dead branches found to delete\''

# rails
alias devlog 'tail -f log/development.log'
alias prodlog 'tail -f log/production.log'
alias testlog 'tail -f log/test.log'
alias rc 'rails console'
alias rcs 'rails console --sandbox'
alias rd 'rails destroy'
alias rdb 'rails dbconsole'
alias rdc 'rails db:create'
alias rdd 'rails db:drop'
alias rdm 'rails db:migrate'
alias rdmd 'rails db:migrate:down'
alias rdmr 'rails db:migrate:redo'
alias rdmrs 'rails db:migrate:reset'
alias rdms 'rails db:migrate:status'

# bundler
alias ba 'bundle add'
alias bck 'bundle check'
alias bcn 'bundle clean'
alias be 'bundle exec'
alias bi 'bundle install'
alias bl 'bundle list'
alias bo 'bundle open'
alias bout 'bundle outdated'
alias bp 'bundle package'
alias bu 'bundle update'
alias bua 'bundle update --all'

# claude wrapper (aws login at most every 12h)
function claude
    if not command -q awslogin
        command claude $argv
        return
    end
    set -l stamp_file ~/.awslogin_last_run
    set -l last 0
    if test -f $stamp_file
        set last (string match -r '^\d+$' <$stamp_file; or echo 0)
    end
    if test (math (date +%s) - $last) -lt 43200
        command claude $argv
    else
        awslogin; and date +%s >$stamp_file; and command claude $argv
    end
end
