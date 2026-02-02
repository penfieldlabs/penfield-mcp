# Relationship Types

Penfield supports 24 relationship types for connecting memories. Connections transform isolated notes into a knowledge graph.

**After storing a memory, always ask:** What does this relate to? Then connect it.

---

## Knowledge Evolution

Use when understanding changes over time.

### supersedes

The new memory replaces the old one. The old understanding is now obsolete.

```
correction → supersedes → original_assumption
```

**Example:** A correction about the root cause supersedes the initial hypothesis.

---

### updates

The new memory adds to or refines the old one without replacing it entirely.

```
new_finding → updates → existing_knowledge
```

**Example:** New details about a system update the existing architecture documentation.

---

### evolution_of

The new memory represents a natural progression from the old one.

```
v2_design → evolution_of → v1_design
```

**Example:** A refined approach that builds on earlier thinking.

---

## Evidence

Use when information validates or challenges existing beliefs.

### supports

The new memory provides evidence for the existing one.

```
benchmark_result → supports → performance_hypothesis
```

**Example:** Test results that confirm a suspected bottleneck.

---

### contradicts

The new memory conflicts with the existing one.

```
new_data → contradicts → old_assumption
```

**Example:** Metrics that disprove an earlier theory.

---

### disputes

The new memory raises questions about the existing one without definitively contradicting it.

```
edge_case → disputes → general_rule
```

**Example:** An exception that challenges but doesn't invalidate a pattern.

---

## Hierarchy

Use for structural relationships between concepts.

### parent_of

The memory is a broader category containing the target.

```
authentication → parent_of → oauth_implementation
```

**Example:** A topic that contains subtopics.

---

### child_of

The memory is a specific instance or subset of the target.

```
jwt_validation → child_of → authentication
```

**Example:** A subtopic within a broader category.

---

### sibling_of

The memories are peers at the same level of hierarchy.

```
oauth → sibling_of → saml
```

**Example:** Alternative approaches to the same problem.

---

### composed_of

The memory is made up of the target memories.

```
auth_system → composed_of → token_service
auth_system → composed_of → user_store
```

**Example:** A system composed of multiple components.

---

### part_of

The memory is a component of the target.

```
rate_limiter → part_of → api_gateway
```

**Example:** A component within a larger system.

---

## Causation

Use for cause-and-effect chains and dependencies.

### causes

The memory directly leads to the target outcome.

```
config_change → causes → outage
```

**Example:** An action that triggered a consequence.

---

### influenced_by

The memory was shaped by the target.

```
architecture_decision → influenced_by → scale_requirements
```

**Example:** A decision that was affected by constraints.

---

### prerequisite_for

The memory must be completed before the target can proceed.

```
database_migration → prerequisite_for → api_v2_launch
```

**Example:** A dependency that blocks progress.

---

## Implementation

Use when something demonstrates, describes, or validates something else.

### implements

The memory is a concrete realization of the target concept.

```
auth_middleware → implements → security_spec
```

**Example:** Code that fulfills a specification.

---

### documents

The memory describes or explains the target.

```
readme → documents → api_endpoints
```

**Example:** Documentation about a system.

---

### tests

The memory validates the target.

```
integration_test → tests → payment_flow
```

**Example:** A test that verifies functionality.

---

### example_of

The memory is an instance demonstrating the target pattern.

```
retry_logic → example_of → exponential_backoff
```

**Example:** A concrete case of an abstract pattern.

---

## Conversation

Use for attribution and dialogue threads.

### responds_to

The memory is a direct response to the target.

```
answer → responds_to → question
```

**Example:** A follow-up that addresses an earlier point.

---

### references

The memory mentions or cites the target.

```
analysis → references → original_report
```

**Example:** A memory that refers to another for context.

---

### inspired_by

The memory draws ideas from the target without directly responding.

```
new_approach → inspired_by → blog_post
```

**Example:** Thinking that was sparked by something else.

---

## Sequence

Use for ordered steps in a process or timeline.

### follows

The memory comes after the target in sequence.

```
deploy_step → follows → build_step
```

**Example:** A step that happens after another.

---

### precedes

The memory comes before the target in sequence.

```
design_phase → precedes → implementation_phase
```

**Example:** A step that happens before another.

---

## Dependencies

### depends_on

The memory requires the target to function or make sense.

```
frontend → depends_on → api
```

**Example:** A component that needs another to work.

---

## Quick Reference

| Category | Types |
|----------|-------|
| **Knowledge Evolution** | `supersedes`, `updates`, `evolution_of` |
| **Evidence** | `supports`, `contradicts`, `disputes` |
| **Hierarchy** | `parent_of`, `child_of`, `sibling_of`, `composed_of`, `part_of` |
| **Causation** | `causes`, `influenced_by`, `prerequisite_for` |
| **Implementation** | `implements`, `documents`, `tests`, `example_of` |
| **Conversation** | `responds_to`, `references`, `inspired_by` |
| **Sequence** | `follows`, `precedes` |
| **Dependencies** | `depends_on` |

---

## Best Practices

1. **Connect immediately** — Don't store memories in isolation. Ask "what does this relate to?" right after storing.

2. **Use specific types** — `supersedes` is different from `updates`. Choose the one that accurately describes the relationship.

3. **Build chains** — A correction that supersedes a hypothesis that was influenced by requirements tells a story.

4. **Traverse with explore** — Use `explore()` to discover connections you may have forgotten about.

5. **Correct, don't delete** — When knowledge evolves, create a correction and connect it with `supersedes`. This preserves history.

---

Copyright © 2025 Penfield™. All rights reserved.
