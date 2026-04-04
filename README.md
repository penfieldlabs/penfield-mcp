# Penfield

**Persistent memory for AI agents.** Store decisions, preferences, and context that survive across sessions. Build knowledge graphs that compound over time. Works with Claude, Cursor, Windsurf, Gemini CLI, and any MCP-compatible tool.

---

## Quick Start

### Claude (Desktop, Mobile, Web)

Add as a custom connector in Settings → Connectors:

```
Name: Penfield
Remote MCP server URL: https://mcp.penfield.app
```

### Claude Code

```bash
claude mcp add --transport http --scope user penfield https://mcp.penfield.app
```

### Cursor

**One-click install:**

[Install Penfield in Cursor](cursor://anysphere.cursor-deeplink/mcp/install?name=Penfield&config=eyJjb21tYW5kIjoibnB4IiwiYXJncyI6WyIteSIsIm1jcC1yZW1vdGUiLCJodHRwczovL21jcC5wZW5maWVsZC5hcHAvIl19)

Cut and paste into your browser:

```
cursor://anysphere.cursor-deeplink/mcp/install?name=Penfield&config=eyJjb21tYW5kIjoibnB4IiwiYXJncyI6WyIteSIsIm1jcC1yZW1vdGUiLCJodHRwczovL21jcC5wZW5maWVsZC5hcHAvIl19
```

Or add manually to `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "Penfield": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.penfield.app/"]
    }
  }
}
```

### Windsurf, Cline, Roo Code, and Others

Add to your MCP configuration file:

```json
{
  "mcpServers": {
    "Penfield": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.penfield.app/"]
    }
  }
}
```

| App | Config Location |
|-----|-----------------|
| Windsurf | `~/.codeium/windsurf/mcp_config.json` |
| Cline | VS Code Settings → Cline → MCP Servers |
| Roo Code | VS Code Settings → Roo Code → MCP Servers |
| Zed | `~/.config/zed/settings.json` under `"context_servers"` |

### Gemini CLI

```bash
gemini mcp add penfield -- npx -y mcp-remote https://mcp.penfield.app/
```

Or add to `~/.gemini/settings.json`:

```json
{
  "mcpServers": {
    "Penfield": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.penfield.app/"]
    }
  }
}
```

---

## What You Get

**17 tools** for persistent memory:

| Category | Tools |
|----------|-------|
| **Memory** | `store`, `recall`, `search`, `fetch`, `update_memory` |
| **Knowledge Graph** | `connect`, `disconnect`, `explore` |
| **Context** | `awaken`, `reflect`, `save_context`, `restore_context`, `list_contexts` |
| **Artifacts** | `save_artifact`, `retrieve_artifact`, `list_artifacts`, `delete_artifact` |

**Hybrid search** combining BM25 (keyword), vector (semantic), and graph (connections) for recall that actually finds what you need.

**Cross-platform sync** — same memory, same knowledge graph, regardless of which tool you connect from.

---

## How It Works

1. **Sign up** at [portal.penfield.app/sign-up](https://portal.penfield.app/sign-up)
2. **Connect** using one of the methods above
3. **Authenticate** when prompted (OAuth flow)
4. **Start using** — your agent now has persistent memory

Every session should start with:

```
awaken()     # Load identity and personality context
reflect()    # Orient on recent work (default: last 7 days)
```

Without these, your agent starts cold with no context.

---

## Documentation

- [Tools Reference](docs/TOOLS.md) — All 17 tools with parameters and examples
- [Memory Types](docs/MEMORY-TYPES.md) — The 11 memory types and when to use each
- [Relationships](docs/RELATIONSHIPS.md) — The 24 relationship types for connecting memories
- [AI Agent Guide](SKILL.md) — Instructions for AI agents using Penfield

---

## Use Cases

**Personal assistant that remembers**
- Your preferences compound over time
- Picks up conversations where you left off
- Learns how you like things done

**Development workflows**
- Track investigation threads across sessions
- Remember architectural decisions and why they were made
- Hand off context between coding sessions

**Research and writing**
- Build knowledge graphs of connected ideas
- Store insights and corrections as understanding evolves
- Checkpoint progress on long-running projects

---

## Also Available

**OpenClaw Native Plugin** — If you use OpenClaw, the native plugin is 4-5x faster (no MCP proxy layer):

```bash
openclaw plugins install openclaw-penfield
openclaw penfield login
```

[openclaw-penfield on GitHub](https://github.com/penfieldlabs/openclaw-penfield) · [openclaw-penfield on npm](https://www.npmjs.com/package/openclaw-penfield)

**API** — Direct HTTP access at `api.penfield.app` for custom integrations.

---

## Links

- MCP: [mcp.penfield.app](https://mcp.penfield.app)
- Website: [penfield.app](https://penfield.app)
- Portal: [portal.penfield.app](https://portal.penfield.app)
- Cursor Directory: [cursor.directory/mcp/penfield](https://cursor.directory/mcp/penfield)
- X: [@penfieldlabs](https://x.com/penfieldlabs)
- GitHub: [@penfieldlabs](https://github.com/penfieldlabs)

[![penfield-mcp MCP server](https://glama.ai/mcp/servers/penfieldlabs/penfield-mcp/badges/card.svg)](https://glama.ai/mcp/servers/penfieldlabs/penfield-mcp)

---

Copyright © 2025 Penfield™. All rights reserved.
