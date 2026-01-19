# Kitty shell integration (manual install)

# Make paths clickable in Kitty:
function __kitty_hook_preexec() {
    printf "\033]133;A\007"
}

function __kitty_hook_precmd() {
    printf "\033]133;C\007"
}

[[ -n "$ZSH_VERSION" ]] && {
  autoload -Uz add-zsh-hook
  add-zsh-hook preexec __kitty_hook_preexec
  add-zsh-hook precmd __kitty_hook_precmd
}

[[ -n "$BASH_VERSION" ]] && {
  PROMPT_COMMAND="__kitty_hook_precmd; $PROMPT_COMMAND"
  trap '__kitty_hook_preexec' DEBUG
}

