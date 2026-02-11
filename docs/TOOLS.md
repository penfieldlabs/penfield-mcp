# Tools Reference

Complete reference for all Penfield MCP tools. Tools are namespaced as `Penfield:tool_name`.

---

## Memory Tools

### store

Store a new memory with automatic type detection.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `content` | string | Yes | Memory content (1-10,000 chars) |
| `tags` | string[] | No | Tags for categorization |
| `importance` | number | No | 0.0–1.0 (auto-calculated if omitted) |

**Note:** Memory type is auto-detected from content. Valid types: fact, insight, conversation, correction, reference, task, checkpoint, relationship, strategy.

**Protected types:** `identity_core` and `personality_trait` are managed exclusively through the `/api/v2/personality` endpoints and cannot be created via `store`. The auto-detection will not produce these types.

**Example:**
```json
{
  "content": "[Preferences] User prefers TypeScript over JavaScript. Values strict typing and explicit error handling.",
  "importance": 0.8,
  "tags": ["preferences", "languages", "typescript"]
}
```

---

### recall

Hybrid search (BM25 + vector + graph). Use when you need context before responding, resuming a topic, or looking up prior decisions.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `query` | string | Yes | Search query |
| `limit` | number | No | Max results (default: 10, max: 100) |
| `source_type` | string | No | Filter: "memory", "document", or null for all |
| `tags` | string[] | No | Filter by tags (OR logic) |
| `start_date` | string | No | Filter by date (ISO 8601) |
| `end_date` | string | No | Filter by date (ISO 8601) |

**Example:**
```json
{
  "query": "authentication architecture decisions",
  "limit": 5,
  "tags": ["architecture"],
  "start_date": "2025-01-01"
}
```

---

### search

Semantic search (higher vector weight). Use for fuzzy concept search when you don't have exact terms.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `query` | string | Yes | Search query |
| `limit` | number | No | Max results (default: 10, max: 100) |

**Example:**
```json
{
  "query": "how errors are handled in the payment flow",
  "limit": 5
}
```

---

### fetch

Get a specific memory by ID.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | UUID | Yes | Memory ID to fetch |

**Example:**
```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000"
}
```

---

### update_memory

Modify an existing memory's content, importance, or tags.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `memory_id` | string | Yes | UUID of the memory to update |
| `content` | string | No | New content |
| `importance` | number | No | New importance score |
| `tags` | string[] | No | New tags (replaces existing) |

**Example:**
```json
{
  "memory_id": "550e8400-e29b-41d4-a716-446655440000",
  "content": "[Preferences] User prefers TypeScript. Recently started using Zod for runtime validation.",
  "importance": 0.85
}
```

---

## Knowledge Graph Tools

### connect

Link two memories with a typed relationship.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `from_memory` | UUID | Yes | Source memory ID |
| `to_memory` | UUID | Yes | Target memory ID |
| `relationship_type` | string | Yes | One of 24 relationship types (see [Relationships](RELATIONSHIPS.md)) |
| `strength` | number | No | 0.0–1.0 (default: 0.5) |

**Example:**
```json
{
  "from_memory": "550e8400-e29b-41d4-a716-446655440000",
  "to_memory": "660e8400-e29b-41d4-a716-446655440001",
  "relationship_type": "supersedes"
}
```

---

### disconnect

Remove a connection between two memories.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `from_memory` | UUID | Yes | Source memory ID |
| `to_memory` | UUID | Yes | Target memory ID |

**Example:**
```json
{
  "from_memory": "550e8400-e29b-41d4-a716-446655440000",
  "to_memory": "660e8400-e29b-41d4-a716-446655440001"
}
```

---

### explore

Traverse the knowledge graph from a starting memory.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `start_memory` | UUID | Yes | Starting memory ID |
| `max_depth` | number | No | Max traversal depth (default: 3, max: 10) |
| `relationship_types` | string[] | No | Filter by relationship types |

**Example:**
```json
{
  "start_memory": "550e8400-e29b-41d4-a716-446655440000",
  "max_depth": 3,
  "relationship_types": ["supports", "contradicts", "supersedes"]
}
```

---

## Context & Analysis Tools

### awaken

Load personality configuration and user preferences for the session. **Call this at the start of every session.**

**Parameters:** None

**Example:**
```json
{}
```

---

### reflect

Analyze memory patterns and generate insights.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `time_window` | string | No | "recent", "today", "week", "month", "1d", "7d", "30d", "90d" (default: "recent") |
| `include_documents` | boolean | No | Include document chunks (default: false) |
| `start_date` | string | No | Filter by date (ISO 8601) |
| `end_date` | string | No | Filter by date (ISO 8601) |

**Example:**
```json
{
  "time_window": "week",
  "start_date": "2025-01-01",
  "end_date": "2025-01-07"
}
```

---

### save_context

Create a checkpoint of cognitive state for session handoffs.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Checkpoint name (must be unique per tenant) |
| `description` | string | No | Detailed cognitive handoff description |

Checkpoint names are unique per tenant. Saving with a duplicate name returns an error.

**Example:**
```json
{
  "name": "API Investigation - 2026-02",
  "description": "Found the bug in auth flow. Key discovery in memory_id: 550e8400-e29b-41d4-a716-446655440000. Next: test fix."
}
```

---

### restore_context

Restore a saved checkpoint.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Checkpoint name to restore |
| `limit` | number | No | Max memories to return (default: 20) |

**Special case:** `name: "awakening"` loads the user's personality configuration.

**Example:**
```json
{
  "name": "API Investigation - 2026-02",
  "limit": 20
}
```

---

### list_contexts

List saved checkpoints with optional filtering and pagination.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `limit` | number | No | Max results (default: 20, max: 100) |
| `offset` | number | No | Number of results to skip (default: 0) |
| `name_pattern` | string | No | Filter by name (case-insensitive substring match) |
| `include_descriptions` | boolean | No | Include full descriptions (default: false) |

**Example:**
```json
{
  "limit": 10,
  "name_pattern": "investigation"
}
```

---

## Artifact Tools

### save_artifact

Store a file (diagrams, notes, code, reference docs).

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | string | Yes | File path/name |
| `content` | string | Yes | File content |
| `content_type` | string | No | MIME type |

**Example:**
```json
{
  "path": "diagrams/architecture-v2.mermaid",
  "content": "graph TD\n  A[Client] --> B[API Gateway]\n  B --> C[Auth Service]",
  "content_type": "text/plain"
}
```

---

### retrieve_artifact

Fetch a previously saved artifact.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | string | Yes | File path/name |

**Example:**
```json
{
  "path": "diagrams/architecture-v2.mermaid"
}
```

---

### list_artifacts

List stored files in a directory.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | string | No | Directory path. Default: root |

**Example:**
```json
{
  "path": "diagrams/"
}
```

---

### delete_artifact

Remove an artifact.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | string | Yes | File path/name |

**Example:**
```json
{
  "path": "diagrams/old-architecture.mermaid"
}
```

---

## Deprecated Tools

These tools are deprecated and should not be used:

| Tool | Status | Replacement |
|------|--------|-------------|
| `get_storage_access` | Deprecated | Use Portal Documents UI |
| `summarize` | Deprecated | Use `save_context` |

---

Copyright © 2025 Penfield™. All rights reserved.
