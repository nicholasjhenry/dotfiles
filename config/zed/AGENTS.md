## AGENTS.md

- At session start, use `find_path` with glob `**/AGENTS.local.md`, then `**/AGENTS.md`, to locate project-specific instructions. Read any match that sits at a project root level (one path component — e.g., `project_root/AGENTS.local.md`). Do not guess paths.
- You MUST adhere to the `./AGENTS.local.md` or `./AGENTS.md` quality gates.

## Skills

For the initial prompt, UNLESS already prompted, you **MUST** review applicable skills in `$HOME/.agents/skills` and `./waterpark-agents/skills` to determine if any are valid for the task. ONLY read the front-matter to avoid context bloat.

Echo the skills that will be used will be used to fulfill the prompt.
