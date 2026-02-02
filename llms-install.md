# Penfield MCP Server Installation Guide

This guide is designed for AI agents like Cline to install and configure the Penfield MCP server for use with LLM applications including Claude Desktop, Cursor, Windsurf, Cline, Roo Code, and others.

Penfield is a **hosted MCP server** — there is no local installation required. You configure your MCP client to connect to `https://mcp.penfield.app/`.

## Prerequisites

- A Penfield account (sign up at https://portal.penfield.app/sign-up)
- Node.js LTS (for clients using `npx mcp-remote`)

## Installation by Client

### Claude Desktop / Claude Mobile / Claude Web

Add as a custom connector in Settings → Connectors:

```
Name: Penfield
Remote MCP server URL: https://mcp.penfield.app
```

No additional configuration needed. OAuth authentication happens automatically on first use.

### Claude Code

Run this command:

```bash
claude mcp add --transport http penfield https://mcp.penfield.app
```

### Cursor

**Option 1: One-click install**

Use this deep link: `cursor://anysphere.cursor-deeplink/mcp/install?name=Penfield&config=eyJjb21tYW5kIjoibnB4IiwiYXJncyI6WyIteSIsIm1jcC1yZW1vdGUiLCJodHRwczovL21jcC5wZW5maWVsZC5hcHAvIl19`

**Option 2: Manual configuration**

Add to `~/.cursor/mcp.json`:

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

### Cline (VS Code)

Add to `~/Library/Application Support/Code/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json` (macOS) or equivalent path:

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

### Roo Code (VS Code)

Add to `~/Library/Application Support/Code/User/globalStorage/rooveterinaryinc.roo-cline/settings/cline_mcp_settings.json` (macOS) or equivalent path:

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

### Windsurf

Add to `~/.codeium/windsurf/mcp_config.json`:

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

### Zed

Add to `~/.config/zed/settings.json` under `"context_servers"`:

```json
{
  "context_servers": {
    "Penfield": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.penfield.app/"]
    }
  }
}
```

### Gemini CLI

Run this command:

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

## Available Tools

Penfield provides 17 tools organized into four categories:

### Memory (5 tools)
| Tool | Purpose |
|------|---------|
| `store` | Save a memory with content, type, importance, and tags |
| `recall` | Hybrid search (BM25 + vector + graph) to find memories |
| `search` | Semantic search with higher vector weight |
| `fetch` | Retrieve a specific memory by UUID |
| `update_memory` | Modify an existing memory |

### Knowledge Graph (3 tools)
| Tool | Purpose |
|------|---------|
| `connect` | Link two memories with a typed relationship |
| `disconnect` | Remove a connection between memories |
| `explore` | Traverse the graph from a memory |

### Context (5 tools)
| Tool | Purpose |
|------|---------|
| `awaken` | Load identity and personality context (call at session start) |
| `reflect` | Analyze recent activity for patterns and themes |
| `save_context` | Checkpoint cognitive state for handoff |
| `restore_context` | Resume from a saved checkpoint |
| `list_contexts` | List all saved checkpoints |

### Artifacts (4 tools)
| Tool | Purpose |
|------|---------|
| `save_artifact` | Store a file (diagrams, notes, code) |
| `retrieve_artifact` | Fetch a saved artifact |
| `list_artifacts` | List stored files |
| `delete_artifact` | Remove an artifact |

## First Use

After installation, every session should begin with:

```
awaken()
reflect({ time_window: "7d" })
```

- `awaken` loads your identity and personality context
- `reflect` orients you on recent work

Without these calls, you start cold with no context.

## Verify Installation

1. Restart your MCP client application
2. You should see Penfield listed as an available MCP server
3. On first use, you'll be prompted to authenticate via OAuth
4. Test with: `awaken()` — you should receive your personality context

## Troubleshooting

### Authentication Issues
- Ensure you have a Penfield account at https://portal.penfield.app
- Complete the OAuth flow when prompted
- If authentication fails, try removing and re-adding the MCP server configuration

### Connection Issues
- Verify Node.js LTS is installed: `node --version`
- Ensure `npx` is available: `npx --version`
- Check that `https://mcp.penfield.app/` is accessible from your network

### Tools Not Appearing
- Restart your MCP client after configuration changes
- Verify the JSON configuration syntax is correct
- Check the MCP client logs for error messages

## Resources

- Website: https://penfield.app
- Documentation: https://github.com/penfieldlabs/penfield-mcp
- Sign up: https://portal.penfield.app/sign-up
