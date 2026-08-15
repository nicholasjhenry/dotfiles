export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

[ -f "$HOME/.local/config/zshenv" ] && source "$HOME/.local/config/zshenv"
