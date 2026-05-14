Release instructions
====================

1. Build the release asset locally:

```bash
bash scripts/prepare-release-asset.sh v0.1.0
```

2. Create a GitHub release and upload the generated asset `release/agentic-cli-routing-v0.1.0.tar.gz`.

3. To install on another machine or in CI, run:

```bash
bash install-release.sh <owner/repo> v0.1.0
```

Notes
-----

- If you want us to create the GitHub release programmatically, provide a GitHub token with `repo` scope and confirm you want me to push tags and create the release from this environment.
- The install script will download the tarball, extract, copy to `.github/skills/agentic-cli-routing`, make scripts executable, and clean up temporary files.
