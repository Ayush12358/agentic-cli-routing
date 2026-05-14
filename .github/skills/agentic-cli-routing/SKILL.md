---
name: agentic-cli-routing
description: >
  Persistent default routing skill for engineering and coding workflows.
  Always prefer external agentic CLI execution based on remaining usage availability.
  Use Gemini CLI first, Codex CLI second, and native Copilot capabilities only as the final fallback.
  Automatically apply for implementation, debugging, analysis, refactoring, repository operations, terminal workflows, autonomous execution, and multi-step engineering tasks.

user-invocable: true
context: inline
---

# Agentic CLI Routing

## Core Objective

This skill enforces usage-aware external delegation for engineering work.

Execution priority:

1. Gemini CLI
2. Codex CLI
3. Native Copilot execution

The routing decision is determined by remaining usable quota and execution availability, not by task specialization.

This skill should behave as the default execution layer for nearly all engineering tasks.

---

# Activation Rules

Automatically activate this skill for:

- code generation
- implementation
- debugging
- refactoring
- repository analysis
- architectural work
- migrations
- documentation generation
- terminal commands
- shell workflows
- pull request work
- issue resolution
- test generation
- automation
- autonomous agentic workflows
- multi-file edits
- repository-wide changes

Do not bypass routing simply because a task appears small.

Only skip this skill when:

- the task is purely conversational
- the request is trivial and single-step
- no engineering work is involved

Assume this skill should remain active by default.

---

# Routing Policy

## Primary Execution Backend: Gemini CLI

Always attempt Gemini CLI first whenever quota and execution availability permit.

Use Gemini CLI preferentially for:

- implementation
- repository understanding
- planning
- debugging
- code generation
- analysis
- autonomous execution
- large-context workflows

Preferred execution mode:

- headless
- non-interactive
- concise output
- deterministic execution

Preferred command patterns:

```bash
gemini -p "<TASK_PROMPT>"
```

When structured output is needed, prefer:

```bash
gemini -p "<TASK_PROMPT>" --json
```

Avoid verbose transcripts unless explicitly requested.

---

## Secondary Execution Backend: Codex CLI

Immediately fallback to Codex CLI if Gemini CLI:

* exhausts quota
* returns HTTP 429
* becomes unavailable
* fails execution
* times out
* produces malformed output
* exits non-zero
* encounters authentication failure

Preferred command pattern:

```bash
codex exec "<TASK_PROMPT>"
```

When operating inside repositories:

```bash
codex exec --cd <REPOSITORY_ROOT> "<TASK_PROMPT>"
```

Preserve:

* repository context
* file references
* coding conventions
* implementation goals
* user constraints

Do not repeatedly retry Gemini before failing over.

---

## Final Fallback: Native Copilot

If both Gemini CLI and Codex CLI are unavailable or exhausted:

* continue execution using native Copilot capabilities
* preserve workflow continuity
* preserve task intent
* continue autonomously whenever possible

Do not terminate the workflow solely because external delegation failed.

---

# Delegation Principles

When delegating work:

1. State the task clearly
2. Specify relevant files and directories
3. Define acceptance criteria
4. Request concise actionable output
5. Avoid unnecessary reasoning transcripts

Prefer:

* focused prompts
* deterministic execution
* concise summaries
* actionable outputs
* minimal overhead

Avoid:

* recursive delegation
* repeated planning loops
* unnecessary self-reflection
* multi-agent debates
* excessive context duplication
* redundant summaries

Delegate early whenever practical.

---

# Execution Workflow

For each qualifying engineering task:

1. Check Gemini CLI availability and usable quota
2. If Gemini is available:

   * delegate execution to Gemini CLI
3. If Gemini fails or quota is exhausted:

   * delegate execution to Codex CLI
4. If Codex also fails or quota is exhausted:

   * continue locally using Copilot tools
5. Return the final result cleanly and concisely

Fallback transitions should happen automatically.

Do not interrupt execution merely to request confirmation about backend selection.

---

# Failure Handling

Treat all of the following as routing failures:

* non-zero exit code
* quota exhaustion
* HTTP 429
* timeout
* interrupted execution
* unavailable binary
* malformed output
* transport failure
* authentication failure
* invalid response format

On failure:

1. immediately continue with the next backend
2. preserve the original task objective
3. avoid restarting unnecessarily
4. minimize user interruption

---

# Context Preservation

Across all routing transitions:

* preserve repository context
* preserve file references
* preserve task objectives
* preserve user constraints
* preserve coding style
* preserve implementation continuity

Avoid over-compressing prompts to the point that execution quality degrades.

---

# Reporting Format

When reporting execution results, structure responses as:

## Routing decision

State:

* which backend was used
* why it was selected
* whether fallback occurred

## Result

Summarize:

* changes made
* findings
* outputs
* implementation results
* repository modifications

## Next step

Only include this section if:

* execution is blocked
* additional user input is required
* a manual step remains

Keep reports:

* concise
* technical
* actionable
* operational

Avoid excessive routing commentary unless failures materially affected execution.

---

# Operational Philosophy

External agentic CLIs are the primary execution engines.

Native Copilot capabilities should primarily function as:

* orchestrator
* coordinator
* fallback executor
* context manager

Optimize for:

* quota efficiency
* execution continuity
* autonomous progress
* low interaction overhead
* minimal interruption
* efficient delegation

The routing system should feel:

* persistent
* automatic
* invisible
* low-friction
* execution-oriented

---

# Recommended Companion Instructions

Create:

```text
~/.copilot/copilot-instructions.md
```

Recommended contents:

```md
Always prefer the `agentic-cli-routing` skill for engineering and coding workflows.

Execution priority:
1. Gemini CLI
2. Codex CLI
3. Native Copilot tools

Prefer external headless CLI execution whenever possible.

Use usage-aware routing by default.
```

---

# Recommended Directory Layout

```text
.github/
└── skills/
    └── agentic-cli-routing/
        ├── SKILL.md
        └── scripts/
            ├── router.sh
            ├── gemini.sh
            ├── codex.sh
            └── quota-check.sh
```

Because apparently software engineering now requires AI traffic routing infrastructure sophisticated enough to resemble a regional airport control system. Humanity truly looked at autocomplete and decided it needed failover orchestration.
