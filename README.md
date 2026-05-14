Agentic CLI Routing
====================

Lightweight skill and routing helpers that prefer external agentic CLIs (Gemini, Codex) with a Copilot fallback.

Quick install
-------------

Install directly from the repository (recommended):

```bash
# installs the skill from the specified tag (defaults to main)
bash install-from-git.sh Ayush12358/agentic-cli-routing v0.1.1
```

Install from the release asset (standalone installer included):

```bash
# run the installer included in the release/ directory
bash release/installer.sh Ayush12358/agentic-cli-routing v0.1.1
```

How it works
------------

- The skill lives at `.github/skills/agentic-cli-routing` once installed.
- `.github/skills/agentic-cli-routing/scripts/` contains CLI wrappers and a `router.sh` which prefers Gemini, then Codex, then Copilot.
- `.github/skills/agentic-cli-routing/hooks/commit-msg` is a Git hook installer that can invoke the router automatically when `AUTO_ROUTER=1` or when commit messages include `[ai]` or `[agent]`.

Enable automatic activation (git hooks)
-------------------------------------

From your repository root (after install):

```bash
chmod +x .github/skills/agentic-cli-routing/install.sh
bash .github/skills/agentic-cli-routing/install.sh
# or enable always-on routing in your shell
export AUTO_ROUTER=1
```

Download & install (users)
--------------------------

Two simple, supported install methods — pick one:

- Install from the repository (recommended; clones the requested ref and installs the skill):

```bash
# installs the skill from the given tag (defaults to main)
bash install-from-git.sh Ayush12358/agentic-cli-routing v0.1.1
```

- Run the standalone installer packaged in the release assets (no git needed):

```bash
# this script clones the repo at the tag and installs the skill
bash release/installer.sh Ayush12358/agentic-cli-routing v0.1.1
```

Both commands install the skill to `.github/skills/agentic-cli-routing` and make scripts executable. The installers clean up temporary files when finished.

One-line copy/paste installer
-----------------------------

Copy and paste this single command into your terminal to clone the repo, run the bundled release installer for `v0.1.1`, and remove the temporary clone:

```bash
git clone --depth 1 --branch v0.1.1 https://github.com/Ayush12358/agentic-cli-routing.git /tmp/agentic-cli-routing \
	&& chmod +x /tmp/agentic-cli-routing/release/installer.sh \
	&& bash /tmp/agentic-cli-routing/release/installer.sh Ayush12358/agentic-cli-routing v0.1.1 \
	&& rm -rf /tmp/agentic-cli-routing
```

If you prefer to keep the clone, remove the final `rm -rf` segment.

Version-independent installer (copy/paste)
----------------------------------------

This one-liner fetches and runs the installer for the repository's latest release (falls back to `main`):

```bash
curl -sL https://raw.githubusercontent.com/Ayush12358/agentic-cli-routing/main/release/install-latest.sh | bash -s -- Ayush12358/agentic-cli-routing
```

Or, if you prefer `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/Ayush12358/agentic-cli-routing/main/release/install-latest.sh | bash -s -- Ayush12358/agentic-cli-routing
```

Security note
-------------

Only run installers and scripts from sources you trust. The installer clones the repo and runs the skill's `install.sh` if present. Review scripts before executing on production systems.

Support
-------

Open an issue at https://github.com/Ayush12358/agentic-cli-routing/issues
