# nicholasjhenry dotfiles

Personal macOS dotfiles: an XDG-compliant **zsh** setup with
[starship](https://starship.rs) for the prompt, [mise](https://mise.jdx.dev) for
runtime versions, and a delta-powered git config. Managed with
[rcm](https://github.com/thoughtbot/rcm).

## Prerequisites

- [Homebrew](https://brew.sh)
- [rcm](https://github.com/thoughtbot/rcm) — `brew install rcm`
- [1Password CLI](https://developer.1password.com/docs/cli/) (`op`) — used by
  `hooks/post-up` to provision the git identity / signing key

The shell config leans on a handful of CLI tools (installed via Homebrew):
`starship`, `mise`, `zplug`, `eza`, `fd`, `fzf`, `bat`, `ripgrep`, `delta`,
`gh`, `jq`, `glow`. `zplug`, `vim-plug`, and `tmux`'s TPM bootstrap themselves on
first run.

## Install

Clone into `~/Workspaces`:

```sh
mkdir -p ~/Workspaces && cd ~/Workspaces
git clone https://github.com/nicholasjhenry/dotfiles.git
```

Install the dotfiles (the one-time `RCRC` var points `rcup` at this repo's
`rcrc`):

```sh
env RCRC=$HOME/Workspaces/dotfiles/rcrc rcup
```

`rcup` symlinks the files into place and runs `hooks/post-up`, which creates the
required XDG directories, installs vim-plug + TPM, appends `source $ZDOTDIR/main`
to `~/.zshrc`, and provisions secrets (see below). After the first run, `rcup`
symlinks `rcrc` to `~/.rcrc`, so subsequent updates are just:

```sh
rcup
```

Run `rcup` again after pulling new changes to symlink any new files.

## Layout

| Path | Purpose |
| --- | --- |
| `zshenv` → `~/.zshenv` | XDG base dirs + `ZDOTDIR=$XDG_CONFIG_HOME/zsh` |
| `config/zsh/` | Shell config; `main` is the entry point (sourced from `~/.zshrc`) |
| `config/git/` | git `config`, global ignore, commit message template, `template/` hooks (ctags) |
| `config/starship.toml` | Prompt |
| `config/tmux/tmux.conf` | tmux |
| `config/{bundle,ctags,irb,pry,psql}/` | Per-tool config |
| `local/bin/` → `~/.local/bin/` | Small scripts (`note`, `haikunator`, `docker-tag`) |
| `vim/`, `vimrc`, `vimrc.bundles` | vim — the `EDITOR` fallback (Zed is primary); plugins via vim-plug |
| `iterm2/` | iTerm2 color schemes |
| `hooks/post-up` | rcm post-install hook |
| `rcrc` | rcm configuration |

## Local & secret overrides

Machine-local and secret settings live in `~/.config/secrets/` (kept out of this
repo):

- **`~/.config/secrets/shrc`** — sourced last by `config/zsh/main`, so it can
  override anything above it. Put machine-specific env vars, aliases, and
  secrets here. `hooks/post-up` creates an empty one on first run.
- **`~/.config/secrets/gitconfig`** — included by `config/git/config`. Holds your
  git identity and signing key:

  ```ini
  [user]
    name = Your Name
    email = you@example.com
    signingkey = <GPG signing key>
  ```

  `hooks/post-up` provisions this from 1Password
  (`op read op://Setup/gitconfig/notesPlain`). Because `commit.gpgsign = true`,
  commits will fail until this file exists with a valid `signingkey`.

## Credits

Based on and inspired by
[thoughtbot's dotfiles](https://github.com/thoughtbot/dotfiles), whose original
work remains under an
[MIT License](https://github.com/thoughtbot/dotfiles/blob/a8bc74d10c62c813b625c0c8a28a996249d71c4c/LICENSE).
