---
name: penfield
description: Persistent memory for AI agents. Store decisions, preferences, and context that survive across sessions. Build knowledge graphs that compound over time. Hybrid search (BM25 + vector + graph) recalls what matters when you need it.
---

# Penfield Memory

Persistent memory that compounds. You remember conversations, learn preferences, connect ideas, and pick up exactly where you left off—across sessions, days, and tools.

## Every Session Starts Here

Always do this first, before anything else:

```
awaken()
reflect({ time_window: "7d" })
```

`awaken` loads your identity and personality context. `reflect` orients you on recent work. Without these, you're starting cold.

## Tools

### Memory

| Tool | Purpose | When to use |
|------|---------|-------------|
| `store` | Save a memory | User shares preferences, you make a discovery, a decision is made, you learn something worth keeping |
| `recall` | Hybrid search (BM25 + vector + graph) | Need context before responding, resuming a topic, looking up prior decisions |
| `search` | Semantic search (higher vector weight) | Fuzzy concept search when you don't have exact terms |
| `fetch` | Get memory by ID | Following up on a specific memory from recall results |
| `update_memory` | Edit existing memory | Correcting, adding detail, changing importance or tags |

### Knowledge Graph

| Tool | Purpose | When to use |
|------|---------|-------------|
| `connect` | Link two memories | New info relates to existing knowledge, building understanding over time |
| `disconnect` | Remove a link | Connection no longer valid or was made in error |
| `explore` | Traverse graph from a memory | Understanding how ideas connect, finding related context |

### Context & Analysis

| Tool | Purpose | When to use |
|------|---------|-------------|
| `awaken` | Load identity and personality | Start of every session — this is your "boot sequence" |
| `reflect` | Analyze memory patterns | Session start orientation, finding themes, spotting gaps |
| `save_context` | Checkpoint a session | Ending substantive work, preparing for handoff to another agent |
| `restore_context` | Resume from checkpoint | Picking up where you or another agent left off |
| `list_contexts` | List saved checkpoints | Finding previous sessions to resume |

### Artifacts

| Tool | Purpose | When to use |
|------|---------|-------------|
| `save_artifact` | Store a file | Saving diagrams, notes, code, reference docs |
| `retrieve_artifact` | Get a file | Loading previously saved work |
| `list_artifacts` | List stored files | Browsing saved artifacts |
| `delete_artifact` | Remove a file | Cleaning up outdated artifacts |

## Writing Memories That Actually Work

Memory content quality determines whether Penfield is useful or useless. The difference is specificity and context.

**Bad — vague, no context, unfindable later:**
```
"User likes Python"
```

**Good — specific, contextual, findable:**
```
"[Preferences] User prefers Python over JavaScript for backend work.
Reason: frustrated by JS callback patterns and lack of type safety.
Values type hints and explicit error handling. Uses FastAPI for APIs."
```

**What makes a memory findable:**

1. **Context prefix** in brackets: `[Preferences]`, `[Project: API Redesign]`, `[Investigation: Payment Bug]`, `[Decision]`
2. **The "why" behind the "what"** — rationale matters more than the fact itself
3. **Specific details** — names, numbers, dates, versions, not vague summaries
4. **References to related memories** — "This builds on [earlier finding about X]" or "Contradicts previous assumption that Y"

## Memory Types

Use the correct type. The system uses these for filtering and analysis.

| Type | Use for | Example |
|------|---------|---------|
| `fact` | Verified, durable information | "User's company runs Kubernetes on AWS EKS" |
| `insight` | Patterns or realizations | "Deployment failures correlate with Friday releases" |
| `correction` | Fixing prior understanding | "CORRECTION: The timeout isn't Redis — it's a hardcoded batch limit" |
| `conversation` | Session summaries, notable exchanges | "Discussed migration strategy. User leaning toward incremental approach" |
| `reference` | Source material, citations | "RFC 8628 defines Device Code Flow for OAuth on input-constrained devices" |
| `task` | Work items, action items | "TODO: Benchmark recall latency after index rebuild" |
| `strategy` | Approaches, methods, plans | "For user's codebase: always check types.ts first, it's the source of truth" |
| `checkpoint` | Milestone states | "Project at 80% — auth complete, UI remaining" |
| `identity_core` | Immutable identity facts | Set via personality config, rarely stored manually |
| `personality_trait` | Behavioral patterns | Set via personality config, rarely stored manually |
| `relationship` | Entity connections | "User works with Chad Schultz on cybersecurity content" |

## Importance Scores

Use the full range. Not everything is 0.5.

| Score | Meaning | Example |
|-------|---------|---------|
| 0.9–1.0 | Critical — never forget | Architecture decisions, hard-won corrections, core preferences |
| 0.7–0.8 | Important — reference often | Project context, key facts about user's work |
| 0.5–0.6 | Normal — useful context | General preferences, session summaries |
| 0.3–0.4 | Minor — background detail | Tangential facts, low-stakes observations |
| 0.1–0.2 | Trivial — probably don't store | If you're questioning whether to store it, don't |

## Connecting Memories

Connections are what make Penfield powerful. An isolated memory is just a note. A connected memory is understanding.

**After storing a memory, always ask:** What does this relate to? Then connect it.

### Relationship Types (24)

**Knowledge Evolution:** `supersedes` · `updates` · `evolution_of`
Use when understanding changes. "We thought X, now we know Y."

**Evidence:** `supports` · `contradicts` · `disputes`
Use when new information validates or challenges existing beliefs.

**Hierarchy:** `parent_of` · `child_of` · `sibling_of` · `composed_of` · `part_of`
Use for structural relationships. Topics containing subtopics, systems containing components.

**Causation:** `causes` · `influenced_by` · `prerequisite_for`
Use for cause-and-effect chains and dependencies.

**Implementation:** `implements` · `documents` · `tests` · `example_of`
Use when something demonstrates, describes, or validates something else.

**Conversation:** `responds_to` · `references` · `inspired_by`
Use for attribution and dialogue threads.

**Sequence:** `follows` · `precedes`
Use for ordered steps in a process or timeline.

**Dependencies:** `depends_on`
Use when one thing requires another.

## Recall Strategy

Good queries find things. Bad queries return noise.

**Tune search weights for your query type:**

| Query type | bm25_weight | vector_weight | graph_weight |
|-----------|-------------|---------------|--------------|
| Exact term lookup ("Twilio auth token") | 0.6 | 0.3 | 0.1 |
| Concept search ("how we handle errors") | 0.2 | 0.6 | 0.2 |
| Connected knowledge ("everything about payments") | 0.2 | 0.3 | 0.5 |
| Default (balanced) | 0.4 | 0.4 | 0.2 |

**Filter aggressively:**
- `memory_types: ["correction", "insight"]` to find discoveries and corrections
- `importance_threshold: 0.7` to skip noise
- `enable_graph_expansion: true` to follow connections (default, usually leave on)

## Workflows

### User shares a preference

```
store({
  content: "[Preferences] User wants responses under 3 paragraphs unless complexity demands more. Dislikes bullet points in casual conversation.",
  memory_type: "fact",
  importance: 0.8,
  tags: ["preferences", "communication"]
})
```

### Investigation tracking

```
// Start
initial = store({
  content: "[Investigation: Deployment Failures] Reports of 500 errors after every Friday deploy. Checking release pipeline, config drift, and traffic patterns.",
  memory_type: "task",
  importance: 0.7,
  tags: ["investigation", "deployment"]
})

// Discovery — connect to the investigation
discovery = store({
  content: "[Investigation: Deployment Failures] INSIGHT: Friday deploys coincide with weekly batch job at 17:00 UTC. Both compete for DB connection pool. Not a deploy issue — it's resource contention.",
  memory_type: "insight",
  importance: 0.9,
  tags: ["investigation", "deployment", "root-cause"]
})
connect({
  from_memory_id: discovery.id,
  to_memory_id: initial.id,
  relationship_type: "responds_to"
})

// Correction — supersede wrong assumption
correction = store({
  content: "[Investigation: Deployment Failures] CORRECTION: Not a CI/CD problem. Friday batch job + deploy = connection pool exhaustion. Fix: stagger batch job to 03:00 UTC.",
  memory_type: "correction",
  importance: 0.9,
  tags: ["investigation", "deployment", "correction"]
})
connect({
  from_memory_id: correction.id,
  to_memory_id: initial.id,
  relationship_type: "supersedes"
})
```

### Session handoff

```
save_context({
  memory_ids: [discovery.id, correction.id, initial.id],
  session_id: "deployment-investigation-2026-02"
})
```

Next session or different agent:

```
restore_context({
  checkpoint_id: "checkpoint-uuid",
  merge_mode: "append"
})
```

## What NOT to Store

- Verbatim conversation transcripts (too verbose, low signal)
- Easily googled facts (use web search instead)
- Ephemeral task state (use working memory)
- Anything the user hasn't consented to store about themselves
- Every minor exchange (be selective — quality over quantity)

## Tags

Keep them short, consistent, lowercase. 2–5 per memory.

Good: `preferences`, `architecture`, `investigation`, `correction`, `project-name`
Bad: `2026-02-02`, `important-memory-about-deployment`, `UserPreferencesForCommunicationStyle`

## Links

- Website: [penfield.app](https://penfield.app)
- Sign up: [portal.penfield.app/sign-up](https://portal.penfield.app/sign-up)
- X: [@penfieldlabs](https://x.com/penfieldlabs)

---

Copyright © 2025 Penfield™. All rights reserved.
