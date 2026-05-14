Agentic CLI Routing Skill
=========================

This skill provides a lightweight routing layer that prefers the Gemini CLI, falls back to Codex CLI, and finally to a local Copilot fallback.

Install
-------

Place the skill under `.github/skills/agentic-cli-routing` (already done).

Usage
-----

Run the router with a prompt:

```bash
bash .github/skills/agentic-cli-routing/scripts/router.sh "Summarize repository architecture"
```

Configuration
-------------

- Set `GEMINI_QUOTA` environment variable to a positive integer to indicate available Gemini quota. If unset, the router will try to detect the `gemini` binary.

Notes
-----

These scripts are simple helpers and intended as starter templates. Make the wrapper scripts executable (`chmod +x`) if you want to run them directly.
