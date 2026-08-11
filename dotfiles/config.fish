# PATH
fish_add_path /opt/homebrew/opt/libpq/bin
fish_add_path /opt/homebrew/bin
fish_add_path /usr/local/bin
fish_add_path $HOME/.local/bin
fish_add_path (set -q ASDF_DATA_DIR; and echo $ASDF_DATA_DIR; or echo $HOME/.asdf)/shims

# env
set -gx LANG en_US.UTF-8
set -gx EDITOR emacs

# brew (login shell init)
eval (/opt/homebrew/bin/brew shellenv)

# fzf
fzf --fish | source

# zoxide
zoxide init --cmd j fish | source

# starship
starship init fish | source

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

# pennylane
if test -f ~/code/pennylane/jeancaisse/docker.env
    # parse export KEY=VALUE lines directly — no bash needed
    for line in (grep '^export ' ~/code/pennylane/jeancaisse/docker.env)
        set -l parts (string split '=' (string replace 'export ' '' $line) --max 2)
        set -gx $parts[1] $parts[2]
    end
    fish_add_path /opt/homebrew/opt/grep/libexec/gnubin
    fish_add_path /opt/homebrew/opt/findutils/libexec/gnubin
    fish_add_path /opt/homebrew/opt/gnu-sed/libexec/gnubin
    fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin
end

# ssh keychain (background, non-blocking)
ssh-add --apple-load-keychain >/dev/null 2>&1 &

# claude wrapper (aws login)
function claude
    set awslogin ~/code/pennylane/jeancaisse/bin/awslogin
    if not test -f $awslogin
        command claude $argv
        return
    end
    set stamp_file ~/.awslogin_last_run
    set now (date +%s)
    if test -f $stamp_file; and test (math "$now - "(cat $stamp_file)) -lt 43200
        command claude $argv
    else
        cd ~/code/pennylane/jeancaisse; and $awslogin; and date +%s > $stamp_file; and command claude $argv
    end
end
