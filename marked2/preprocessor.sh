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
  mermaid.initialize({ startOnLoad: true });
  Marked.hooks.register('update', function() { mermaid.run(); });
</script>
EOF)

# Add Mermaid script to the INPUT
OUTPUT=$(echo -e "$MERMAID_SCRIPT\n$INPUT")

# Output the result to stdout (back to Marked 2)
echo "$OUTPUT"
