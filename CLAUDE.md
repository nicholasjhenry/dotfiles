# CLAUDE.md

Personal macOS dotfiles. Single-user, managed with [rcm](https://github.com/thoughtbot/rcm). XDG-compliant zsh setup; bash scripts in `local/bin/`. No build system, no tests — edit, reload shell, observe.

## Architecture

- `zshenv` (→ `~/.zshenv`) sets XDG paths and `ZDOTDIR=$XDG_CONFIG_HOME/zsh`.
- `~/.zshrc` sources `$ZDOTDIR/main`, which is the orchestrator.
- `config/zsh/main` has a **critical ordering contract**:
  1. `env` → `plugins` → `completion` (ordered prelude — fpath populated before `compinit`)
  2. feature modules (`aliases`, `bindkey`, `fzf`, `git`, etc. — order-independent)
  3. `prompt` (last, installs precmd hooks)
  4. `~/.config/secrets/shrc` (last of all — overrides everything)
- `hooks/post-up` runs after `rcup`: creates XDG dirs, bootstraps vim-plug + TPM, appends the `source $ZDOTDIR/main` line, provisions `~/.config/secrets/gitconfig` from 1Password.
- Secrets (`~/.config/secrets/`) live **outside the repo**. `gitconfig` is required because `commit.gpgsign = true`.

## Tech stack

- macOS, zsh, bash 3.2+ (system bash) for `local/bin/` scripts
- Homebrew-installed: starship, mise, zplug, eza, fd, fzf, bat, ripgrep, delta, gh, jq, glow
- 1Password CLI (`op`) for secret provisioning
- vim 9 (EDITOR fallback; Zed is primary editor)
- Format shell files with `shfmt -i 2` (2-space indent, Google style)

## Layout

```
zshenv              XDG + ZDOTDIR
rcrc                rcm config (which dirs to symlink)
config/zsh/         shell modules, sourced by main
config/git/         git config + delta + commit template
config/{tmux,starship,bundle,irb,pry,psql,ctags}/
local/bin/          standalone scripts (note, haikunator, docker-tag)
hooks/post-up       rcm post-install hook
vim/, vimrc, vimrc.bundles
```

## Conventions

- **Commits:** `<area>: <imperative lowercase>` — e.g., `zsh/env: strip overstrike sequences before piping man to bat`, `note: drop the sed delimiter in pick_note`. Body explains why.
- **Comments: WHY only.** Never describe what the code does. Every existing comment in this repo explains a non-obvious reason (a bug worked around, an ordering constraint, a shell quirk). If the WHY is obvious, omit the comment.
- **`set -euo pipefail`** at the top of every bash script in `local/bin/` and `hooks/`.
- **Quote paths.** Recent history is mostly hardening quotes — don't regress.
- **Run `shfmt -i 2`** on any shell file you touch before considering the change done.
- **Guard optional tools:** `command -v bat >/dev/null && export MANPAGER=...`. Never assume Homebrew tools are present.
- **Cache expensive shell-outs once:** see `BREW_PREFIX` in `config/zsh/env`, reused by `plugins`, `completion`, `homebrew`.
- **XDG everywhere:** `HISTFILE="$XDG_STATE_HOME/zsh/history"`, `PSQLRC="$XDG_CONFIG_HOME/psql/psqlrc"`, etc. New tool configs go under `$XDG_CONFIG_HOME/<tool>/`.
- **Functions for runtime values, aliases for static strings.** `changelog()` in `config/zsh/git` shells out at call time; static strings stay as `alias`.
- **Don't shadow builtins.** See `find_note` (not `find`) in `local/bin/note`.

## Real examples

Guarded export (`config/zsh/env`):

~~~sh
command -v bat >/dev/null && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
~~~

Idempotent append (`hooks/post-up`):

~~~sh
if ! grep -Fqs "$text" "$zshrc"; then
  printf "\n%s\n" "$text" >>"$zshrc"
fi
~~~

Function with usage block (`config/zsh/aliases` — pattern to follow for non-trivial helpers):

~~~sh
# Fetch all comments... for a pull request and write them to ./tmp/pr-<number>.json.
#
# USAGE
#   pr_json <pr-number>
function pr_json() { ... }
~~~

## Do NOT

- **Don't add abstractions.** These are shell scripts — the simplest thing that works wins. No wrapper functions, no "framework", no indirection layer. Three similar lines beat a premature helper.
- **Don't add backward-compat shims.** Personal repo — break forward, delete the old code.
- **Don't write WHAT comments.** `# Set PATH` above `export PATH=...` is noise.
- **Don't use `xargs` to load env files** — quotes and spaces break it. Use `set -a; source ./.env; set +a` (see `local/bin/note`).
- **Don't use `echo -e`.** Use `printf` — portable and explicit.
- **Don't shell out repeatedly for the same value.** Cache it in a variable at first use (see `BREW_PREFIX`).
- **Don't break the `config/zsh/main` ordering.** Plugins must run before completion; secrets must be last. If unsure, ask before reordering.
- **Don't commit secrets or the contents of `~/.config/secrets/`.** That directory is intentionally outside the repo.

## Maintenance

- Update this file when: a new tool joins the stack, a new convention emerges from a commit-fix cycle, or an AI session keeps making the same mistake.
- Quarterly review aligned with `brew upgrade` cycles.
