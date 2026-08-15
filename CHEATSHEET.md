# Cheatsheet

Everything in this repo you can actually type. Shell is zsh in **vi mode**, so
`ESC` → normal mode, `i` → insert.

- [Shell](#shell)
- [Aliases & functions](#aliases--functions)
- [Key bindings](#key-bindings)
- [fzf](#fzf)
- [Scripts (`~/.local/bin`)](#scripts-localbin)
- [Git](#git)
- [tmux](#tmux)
- [vim](#vim)
- [REPLs](#repls)
- [Maintenance](#maintenance)

---

## Shell

| Type | Get |
| --- | --- |
| `Documents/notes` | Bare directory path = `cd` into it (`AUTOCD`) |
| `cmd # note to self` | `#` comments work at the prompt |
| `<space>secret-cmd` | Leading space keeps the command out of history |
| `!!` | Previous command — expands inline when you hit `Space` |
| `!$` | Last argument of the previous command |
| `doc<Tab>` | Case-insensitive completion → `Documents` |
| `<Tab><Tab>` | Interactive completion menu — arrow or `Tab` through matches |

---

## Aliases & functions

### Listing (eza)

| Type | Get |
| --- | --- |
| `ls` | `eza --icons=auto` |
| `ll` | Long, human sizes, git status |
| `la` | Long, including dotfiles |
| `tree` | Recursive tree view |

### Navigation & system

| Type | Get |
| --- | --- |
| `-` | `cd -` — back to previous directory |
| `~dl` | Named directory for `~/Downloads` — works anywhere a path does |
| `ch <url\|file>` | Open in Google Chrome |
| `flushcache` | Flush the macOS DNS cache |

```sh
cd ~dl
mv ~dl/report.pdf .
```

### Global aliases (expand anywhere on the line)

| Type | Get | Example |
| --- | --- | --- |
| `NE` | `2>/dev/null` | `make NE` |
| `NO` | `>/dev/null` | `noisy-cmd NO` |
| `NUL` | `>/dev/null 2>&1` | `cmd NUL` |
| `C` | `\| pbcopy` | `git log -1 C` |

### Suffix alias

| Type | Get |
| --- | --- |
| `notes.md` | Any `.md` file with no command in front pipes through `bat` |

### Git & GitHub

| Type | Get |
| --- | --- |
| `gcan` | `git commit --amend --no-edit` |
| `changelog` | Commits since the last tag as `- <date> <body>`, minus `Bump` commits |
| `changed-tests` | `*_test.exs` files changed vs `origin/main`, relative to cwd |
| `pr_json <n>` | PR body + comments + reviews → `./tmp/pr-<n>.json` (needs `gh`) |
| `ghciw` | Watch the current GH Actions run, then macOS-notify on finish |

```sh
changed-tests | xargs mix test --seed 0 --max-failures 1
pr_json 42 && jq '.comments' tmp/pr-42.json
```

### Elixir / BEAM

| Type | Get |
| --- | --- |
| `flaker <n> <test-file>` | Run a test file `n` times, stop at first failure |
| `erl-version` | Print the exact OTP version string |
| `mise-install` | `mise install` with the Erlang build flags (wxWidgets, OpenSSL, docs) |

```sh
flaker 30 apps/engine/test/engine/listings_test.exs:2165
```

### Misc

| Type | Get |
| --- | --- |
| `gpg-test` | Smoke-test GPG signing with a 30s timeout — run it first when a commit fails with an opaque signing error |
| `claude_models` | List Anthropic model IDs for `$ANTHROPIC_API_KEY` |

---

## Key bindings

### `^O` leader (custom widgets)

| Press | Get |
| --- | --- |
| `^O c` | Copy the current command line to the clipboard |
| `^O g c` | Insert `git commit -m ""` with the cursor between the quotes |

### Line editing

| Press | Get |
| --- | --- |
| `↑` / `↓` | History **substring** search on what you've typed so far |
| `Ctrl+←` / `Ctrl+→` | Move by word |
| `Ctrl+K` | Kill to end of line |
| `→` / `End` | Accept the autosuggestion |
| `ESC` then `v` | Open the current command in `$EDITOR` |
| `ESC` then `cw` / `ci"` / `dd` / `.` | vi normal mode on the command line |

---

## fzf

| Press | Get |
| --- | --- |
| `Ctrl+T` | Paste a file path onto the line (with `bat` preview) |
| `Ctrl+R` | Fuzzy history search |
| `Alt+C` | `cd` into a subdirectory |
| `**<Tab>` | Fuzzy completion trigger after any command |

---

## Scripts (`~/.local/bin`)

### `note` — task runner over `~/.notes`

| Type | Get |
| --- | --- |
| `note` | Help |
| `note <path>` | Display a note (`glow`, or `bat` + copy for `snippets/*`) |
| `note find` | Fuzzy-pick, then display |
| `note copy` | Fuzzy-pick, then copy to clipboard |
| `note edit` | Fuzzy-pick, then open in `$EDITOR` |
| `note new <path>` | Create dirs as needed and edit |
| `note log <name>` | New timestamped note under `log/` |
| `note search <pattern>` | `rg` across all notes |
| `note list` | List every note |
| `note persist` | `git add . && git commit && git push` in the notes repo |

### Everything else

| Type | Get |
| --- | --- |
| `tip` | One random row from this cheatsheet — also runs on every new shell |
| `haikunator` | Random `adjective_noun` name (`quiet_waterfall`) for branches and containers |
| `docker-tag <os> <elixir> <otp>` | Page Docker Hub for a matching `hexpm/elixir` tag |

```sh
docker-tag debian 1.15.7 26.1.2
```

---

## Git

### Aliases

| Type | Get |
| --- | --- |
| `git s` / `git st` | `status` |
| `git co` | `checkout` |
| `git ci` | `commit` |
| `git df` / `git dfc` | `diff` / `diff --cached` |
| `git l` | One-line graph log with author + relative date |
| `git unstage` | `reset HEAD` |
| `git revert-last-commit` | `reset --soft HEAD^` |
| `git track` | Set upstream to `origin/<current-branch>` |
| `git sweep` | Delete merged branches, never `master`/`main`/`develop` |
| `git force-sweep` | Force-delete every branch but `master` |
| `git rbm` / `git pom` / `git phm` | `rebase master` / `push origin master` / `push heroku master` |
| `git sm` / `sp` / `sl` | git-friendly `smart-merge` / `smart-pull` / `smart-log` |
| `git sba <repo> <prefix>` | `subtree add --squash` |
| `git sbu <repo> <prefix>` | `subtree pull --squash` |
| `git ctags` | Regenerate `.git/tags` |

### In the pager (delta)

| Press | Get |
| --- | --- |
| `n` / `N` | Jump to the next / previous diff section |

### Commit messages

Conventional Commits, imperative, lowercase, ≤50 chars.

```
feat(zsh): add bookmarks module
fix(git): quote paths in sweep alias
feat(api)!: drop v1 endpoints
```

Types: `feat` `fix` `perf` `refactor` `style` `docs` `test` `build` `ci`
`chore` `revert`.

---

## tmux

**Prefix is `Ctrl+X`** (not `Ctrl+B`).

| Press | Get |
| --- | --- |
| `prefix r` | Reload `~/.config/tmux/tmux.conf` |
| `prefix \|` / `prefix -` | Split vertical / horizontal, keeping the current path |
| `prefix c` | New window in the current path |
| `prefix h j k l` | Select pane left/down/up/right |
| `prefix H J K L` | Resize pane by 5 (repeatable) |
| `prefix I` | Install plugins (TPM) |
| `Ctrl+L` | Clear screen **and** scrollback (no prefix needed) |

### Copy mode (vi keys)

| Press | Get |
| --- | --- |
| `prefix ESC` | Enter copy mode |
| `v` / `V` / `r` | Begin selection / select line / rectangle toggle |
| `y` | Copy and exit |
| `prefix p` | Paste buffer |
| `prefix Ctrl+C` / `prefix Ctrl+V` | tmux buffer ↔ macOS clipboard |
| Mouse drag | Selects and copies to the macOS clipboard on release |

---

## vim

Leader is `,`.

| Press | Get |
| --- | --- |
| `jj` | Escape to normal mode |
| `,,` | Switch to the previous file |
| `,t` | FZF file finder |
| `,p` | FZF buffer list |
| `,a` | `Ack!` search (uses `ag` when present) |
| `,e` / `,v` | Edit / view a file in the current file's directory |
| `,l` | Toggle invisible characters |
| `,rt` | Remove trailing whitespace |
| `,d` | Dash lookup for the word under the cursor |
| `gV` | Visually reselect the last edited or pasted text |
| `Ctrl+h/j/k/l` | Window navigation |
| `Ctrl+]` / `g Ctrl+]` | Jump to tag / pick from ambiguous matches |
| `%%` (cmdline) | Expands to the current file's directory |
| `w!!` (cmdline) | Save with sudo |
| `F2` | Toggle paste mode |

### Tabs

`,tt` new · `,te` edit · `,tc` close · `,to` only · `,tn` next · `,tp` prev ·
`,tf` first · `,tl` last · `,tm` move

### Alignment (Tabular)

`,ae` on `=` · `,ar` on `=>` · `,at` on `|` · `,ac` on `:`
Markdown tables auto-align as you type `|`.

### Ruby / RSpec

| Press | Get |
| --- | --- |
| `,r` | Send the current test file to tmux |
| `,R` | Send the focused test (cursor line) to tmux |
| `,g` | Run the whole suite (detects zeus / `bin/rspec_all` / `bin/rspec`) |
| `F7` / `F6` | xmpfilter run / mark |
| `:PromoteToLet` | Turn `foo = bar` into `let(:foo) { bar }` |

### Code Climate

`,aa` project · `,ao` open files · `,af` current file

### In an fzf window

`Ctrl+T` tab · `Ctrl+X` split · `Ctrl+V` vsplit · `Ctrl+Q` → quickfix list

### Commands

| Type | Get |
| --- | --- |
| `:Shell <cmd>` | Run a shell command into a scratch buffer |
| `:TagFiles` | List the active tag files |
| `:PlugInstall` / `:PlugClean!` | vim-plug install / prune |

---

## REPLs

### psql

| Type | Get |
| --- | --- |
| `:show_slow_queries` | Saved query — top 100 statements by total time from `pg_stat_statements` |

### pry

`c` continue · `s` step · `n` next · `f` finish

### irb

| Type | Get |
| --- | --- |
| `ap obj` | `awesome_print` an object |
| `y obj` | Dump an object as YAML |

---

## Maintenance

| Type | When |
| --- | --- |
| `rcup` | After pulling changes, or adding a new file to the repo |
| `env RCRC=$HOME/Workspaces/dotfiles/rcrc rcup` | First install only |
| `scripts/precommit` | **Required** after editing `hooks/`, `local/bin/`, `scripts/`, or `config/zsh/` |
| `exec zsh` | Reload the shell after a config change |
| `prefix r` | Reload tmux config |
| `:PlugInstall` | After adding to `vimrc.bundles` |
| `brew upgrade` | Quarterly, alongside a `CLAUDE.md` review |
