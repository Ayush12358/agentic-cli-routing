Agentic CLI Routing
====================

Lightweight skill and routing helpers that prefer external agentic CLIs (Gemini, Codex) with a Copilot fallback.

One-line cross-platform installers
----------------------------------

Use the appropriate single-line command below for your platform. Both attempt to run the release-bundled installer (preferred) or copy the skill files directly, then clean up temporary files.

Unix / macOS / WSL (bash):

```bash
curl -sL https://raw.githubusercontent.com/Ayush12358/agentic-cli-routing/main/release/install-latest.sh | bash -s -- Ayush12358/agentic-cli-routing
```

If you prefer `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/Ayush12358/agentic-cli-routing/main/release/install-latest.sh | bash -s -- Ayush12358/agentic-cli-routing
```

Windows (PowerShell):

```powershell
iwr -useb https://raw.githubusercontent.com/Ayush12358/agentic-cli-routing/main/release/install-latest.ps1 | pwsh -c - -Ayush12358/agentic-cli-routing
```

Notes
-----

- The installer attempts to use the latest GitHub release tag; if none is available it falls back to the `main` branch.
- Review scripts before running them on production systems.
- The scripts clean up temporary files by default; if you want to keep the temporary clone, run the installer steps manually instead of using the one-liners.

Support
-------

Open an issue at https://github.com/Ayush12358/agentic-cli-routing/issues
