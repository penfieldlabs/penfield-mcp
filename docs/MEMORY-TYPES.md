# Memory Types

Penfield supports 11 memory types. Using the correct type enables better filtering, analysis, and recall.

---

## Core Types

### fact

Verified, durable information that remains true over time.

**Use for:**
- User preferences and settings
- Technical specifications
- Organizational information
- Stable reference data

**Examples:**
- "User's company runs Kubernetes on AWS EKS"
- "The API uses OAuth 2.0 with PKCE for authentication"
- "User prefers TypeScript over JavaScript for all new projects"

---

### insight

Patterns, realizations, or conclusions drawn from observations.

**Use for:**
- Discovered patterns
- Analysis conclusions
- Learned behaviors
- Non-obvious connections

**Examples:**
- "Deployment failures correlate with Friday releases"
- "User tends to prefer functional approaches over OOP"
- "Performance issues appear when batch size exceeds 1000"

---

### correction

Fixes to prior understanding. Critical for evolving knowledge accurately.

**Use for:**
- Superseding incorrect assumptions
- Updating outdated information
- Recording "we thought X but actually Y"

**Examples:**
- "CORRECTION: The timeout isn't Redis — it's a hardcoded batch limit"
- "CORRECTION: User prefers Zod over io-ts (earlier assumption was wrong)"
- "CORRECTION: The outage was DNS, not the load balancer"

---

### conversation

Summaries or notable exchanges from sessions.

**Use for:**
- Session summaries
- Important discussions
- Decision-making conversations
- Context that explains how conclusions were reached

**Examples:**
- "Discussed migration strategy. User leaning toward incremental approach over big-bang"
- "Reviewed PR feedback — user wants smaller, more focused commits"
- "Walked through the auth flow; identified three potential failure points"

---

### reference

Source material, citations, and external documentation.

**Use for:**
- RFC and spec references
- Documentation links
- Quoted material
- External sources

**Examples:**
- "RFC 8628 defines Device Code Flow for OAuth on input-constrained devices"
- "User's internal wiki documents the deploy process at /wiki/deploy-runbook"
- "The Stripe API docs specify idempotency keys must be UUIDs"

---

### task

Work items, action items, and todos.

**Use for:**
- Pending work
- Follow-up items
- Things to investigate
- Deferred decisions

**Examples:**
- "TODO: Benchmark recall latency after index rebuild"
- "ACTION: Review the rate limiting implementation before launch"
- "INVESTIGATE: Why does the batch job fail on the 15th of each month?"

---

### strategy

Approaches, methods, and plans for accomplishing goals.

**Use for:**
- Problem-solving approaches
- Workflow preferences
- Mental models for a codebase
- Repeatable processes

**Examples:**
- "For user's codebase: always check types.ts first, it's the source of truth"
- "When debugging auth issues: check token expiry → validate scopes → review middleware order"
- "User prefers trunk-based development with short-lived feature branches"

---

### checkpoint

Milestone states and progress markers.

**Use for:**
- Project progress snapshots
- Phase completion markers
- Handoff points

**Examples:**
- "Project at 80% — auth complete, UI remaining"
- "Phase 1 complete: data migration done, starting Phase 2 validation"
- "MVP shipped, collecting user feedback before v1.1"

---

## Identity Types

### identity_core

Core AI identity information (immutable). **Protected type** — cannot be created or updated via the memories API or MCP `store` tool. Managed through the `/api/v2/personality` endpoints or [portal](https://portal.penfield.app/personality).

**Use for:**
- Core identity attributes
- Unchanging characteristics
- Foundational context

**Examples:**
- "User is a senior backend engineer at Acme Corp"
- "User's timezone is America/Los_Angeles"

---

### personality_trait

AI personality characteristics (evolvable). **Protected type** — cannot be created or updated via the memories API or MCP `store` tool. Managed through the `/api/v2/personality` endpoints or [portal](https://portal.penfield.app/personality). Custom traits are a Premium+ feature.

**Use for:**
- Communication style preferences
- Behavioral tendencies
- Interaction patterns

**Examples:**
- "User prefers concise responses without excessive caveats"
- "User likes technical depth but dislikes jargon"

---

### relationship

Connections between entities (people, projects, systems).

**Use for:**
- People the user works with
- Project relationships
- System dependencies

**Examples:**
- "User works with Chad Schultz on cybersecurity content"
- "Project Alpha depends on the shared auth library"
- "User reports to Sarah (VP Engineering)"

---

## Choosing the Right Type

| Situation | Type |
|-----------|------|
| User tells you a preference | `fact` |
| You discover a pattern | `insight` |
| You were wrong about something | `correction` |
| Summarizing what was discussed | `conversation` |
| Citing a spec or doc | `reference` |
| Something needs to be done | `task` |
| Documenting an approach | `strategy` |
| Marking progress | `checkpoint` |
| Core user/agent identity | `identity_core` |
| Behavioral preferences | `personality_trait` |
| People/project connections | `relationship` |

---

Copyright © 2025 Penfield™. All rights reserved.
