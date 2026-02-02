# Tools Reference

Complete reference for all Penfield MCP tools. Tools are namespaced as `Penfield:tool_name`.

---

## Memory Tools

### store

Store important information as a memory with content, tags, and importance scoring.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `content` | string | Yes | The memory content. Be specific and include context. |
| `memory_type` | string | Yes | One of: `fact`, `insight`, `correction`, `conversation`, `reference`, `task`, `strategy`, `checkpoint`, `identity_core`, `personality_trait`, `relationship` |
| `importance` | number | No | 0.0–1.0 score. Default: 0.5 |
| `tags` | string[] | No | 2–5 lowercase tags for categorization |

**Example:**
```json
{
  "content": "[Preferences] User prefers TypeScript over JavaScript. Values strict typing and explicit error handling.",
  "memory_type": "fact",
  "importance": 0.8,
  "tags": ["preferences", "languages", "typescript"]
}
```

---

### recall

Hybrid search combining BM25 (keyword), vector (semantic), and graph (connections) to find relevant memories.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `query` | string | Yes | Search query |
| `limit` | number | No | Max results. Default: 10 |
| `memory_types` | string[] | No | Filter by memory types |
| `importance_threshold` | number | No | Minimum importance (0.0–1.0) |
| `bm25_weight` | number | No | Keyword matching weight. Default: 0.4 |
| `vector_weight` | number | No | Semantic similarity weight. Default: 0.4 |
| `graph_weight` | number | No | Graph traversal weight. Default: 0.2 |
| `enable_graph_expansion` | boolean | No | Follow connections. Default: true |
| `time_window` | string | No | Filter by recency: `1d`, `7d`, `30d`, etc. |

**Example:**
```json
{
  "query": "authentication architecture decisions",
  "limit": 5,
  "memory_types": ["fact", "insight"],
  "importance_threshold": 0.7,
  "bm25_weight": 0.3,
  "vector_weight": 0.5,
  "graph_weight": 0.2
}
```

---

### search

Semantic search with higher vector weight. Use when you don't have exact terms but know the concept.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `query` | string | Yes | Semantic search query |
| `limit` | number | No | Max results. Default: 10 |
| `memory_types` | string[] | No | Filter by memory types |

**Example:**
```json
{
  "query": "how errors are handled in the payment flow",
  "limit": 5
}
```

---

### fetch

Retrieve a single memory by its UUID.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `memory_id` | string | Yes | UUID of the memory |

**Example:**
```json
{
  "memory_id": "550e8400-e29b-41d4-a716-446655440000"
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
| `from_memory_id` | string | Yes | Source memory UUID |
| `to_memory_id` | string | Yes | Target memory UUID |
| `relationship_type` | string | Yes | One of 24 relationship types (see [Relationships](RELATIONSHIPS.md)) |

**Example:**
```json
{
  "from_memory_id": "550e8400-e29b-41d4-a716-446655440000",
  "to_memory_id": "660e8400-e29b-41d4-a716-446655440001",
  "relationship_type": "supersedes"
}
```

---

### disconnect

Remove a connection between two memories.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `from_memory_id` | string | Yes | Source memory UUID |
| `to_memory_id` | string | Yes | Target memory UUID |

**Example:**
```json
{
  "from_memory_id": "550e8400-e29b-41d4-a716-446655440000",
  "to_memory_id": "660e8400-e29b-41d4-a716-446655440001"
}
```

---

### explore

Traverse the knowledge graph from a memory, discovering connected memories up to a configurable depth.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `memory_id` | string | Yes | Starting memory UUID |
| `depth` | number | No | How many hops to traverse. Default: 2 |
| `relationship_types` | string[] | No | Filter by relationship types |

**Example:**
```json
{
  "memory_id": "550e8400-e29b-41d4-a716-446655440000",
  "depth": 3,
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

Analyze recent activity to find patterns, themes, and insights.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `time_window` | string | No | Time range to analyze: `1d`, `7d`, `30d`. Default: `7d` |
| `focus_areas` | string[] | No | Topics to focus analysis on |

**Example:**
```json
{
  "time_window": "7d",
  "focus_areas": ["project-alpha", "architecture"]
}
```

---

### save_context

Save cognitive state for session handoff or checkpointing.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `memory_ids` | string[] | No | Specific memories to include |
| `session_id` | string | No | Human-readable session identifier |
| `summary` | string | No | Brief description of the checkpoint |

**Example:**
```json
{
  "memory_ids": ["550e8400-e29b-41d4-a716-446655440000"],
  "session_id": "api-redesign-2026-02",
  "summary": "Completed auth module, starting on rate limiting"
}
```

---

### restore_context

Resume work from a saved context checkpoint.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `checkpoint_id` | string | Yes | UUID of the checkpoint |
| `merge_mode` | string | No | `replace` or `append`. Default: `append` |

**Example:**
```json
{
  "checkpoint_id": "770e8400-e29b-41d4-a716-446655440002",
  "merge_mode": "append"
}
```

---

### list_contexts

List all saved context checkpoints.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `limit` | number | No | Max results. Default: 20 |

**Example:**
```json
{
  "limit": 10
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
