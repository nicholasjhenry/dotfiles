#!/bin/bash

# Read input from stdin (piped from Marked 2)
INPUT=$(cat)

# # Convert Markdown to HTML using pandoc
# HTML=$(echo "$INPUT" | pandoc -f markdown -t html)

# Mermaid initialization script
MERMAID_SCRIPT=$(cat <<'EOF'
<script src="https://unpkg.com/mermaid@10/dist/mermaid.min.js"></script>
<script>
  mermaid.initialize({ startOnLoad: true });
  Marked.hooks.register('update', function() { mermaid.run(); });
</script>
EOF
)

# Emit the Mermaid script followed by the original input.
# printf is portable; `echo -e` depends on a bash flag and gets weird with
# backslashes in $INPUT.
printf '%s\n%s\n' "$MERMAID_SCRIPT" "$INPUT"
