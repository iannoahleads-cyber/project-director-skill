# Project Director

Project Director is a Codex skill for coordinating project work through a main director window and focused subagent groups.

Use it when a task involves multi-file coding, debugging, configuration, research, document creation, long-running work, or context compaction risk. The main window preserves the mission, constraints, decisions, and verification state while explorer, worker, and reviewer groups handle bounded lanes of work.

## Install

Copy this folder into your Codex skills directory:

```powershell
Copy-Item -Recurse . "$env:USERPROFILE\.codex\skills\project-director"
```

Then restart Codex.

## Use

Invoke it in a new Codex conversation:

```text
Use $project-director to coordinate this project. Act as the director and open subagent groups when useful.
```

Chinese trigger examples:

```text
用 $project-director 做这个项目，你当总监开几组 subagent 分工推进。
这个任务可能很长，帮我总控、分组、记录要求，最后统一验收。
```

## What It Enforces

- The main window owns the mission, memory, decisions, integration, and final delivery.
- Small or tightly coupled tasks stay local.
- Ordinary project work may use 2-3 focused groups when authorized.
- Heavy or long-running work uses a control log, explicit work lanes, and verification checkpoints.
- Explorers investigate without editing.
- Workers may edit only inside assigned ownership.
- Reviewers check spec compliance, code quality, or verification.
- Final output is one director summary, not pasted agent logs.

## Files

- `SKILL.md` - Skill instructions and trigger description.
- `agents/openai.yaml` - Codex UI metadata.

