# Penfield

Persistent memory and a knowledge graph for AI agents. Penfield stores what your AI learns, links it into a knowledge graph, and finds it again with hybrid search (keyword, semantic and graph). The same memory works across every AI app you connect: Claude, ChatGPT, Cursor, Codex, Gemini, Grok, Perplexity and any other MCP client.

Penfield is a hosted MCP server, so there is nothing to install.

## Connect

You need a Penfield account: [sign up here](https://portal.penfield.app/sign-up).

| Setting | Value |
|---------|-------|
| **Server URL** | `https://mcp.penfield.app` |
| **Transport** | Streamable HTTP |
| **Authentication** | OAuth. You sign in to Penfield in your browser, and the app registers itself automatically. No API key is needed. |

1. In your AI app, add a custom connector (some apps call it an MCP server, plugin, app or integration) with the server URL above.
2. Sign in to Penfield when the app asks, and click **Authorize**.
3. Start a new conversation and type `Penfield Awaken`.

Apps configured with a file take an entry like this (key names vary by app):

```json
{
  "mcpServers": {
    "penfield": {
      "type": "http",
      "url": "https://mcp.penfield.app"
    }
  }
}
```

If your app can only start local servers, or can't sign in to remote servers, connect through [`mcp-remote`](https://docs.penfield.app/onboarding/mcp-remote-setup/).

Step-by-step guides for each app are at **[docs.penfield.app](https://docs.penfield.app/onboarding/)**.

## Documentation

- [Setup guides](https://docs.penfield.app/onboarding/) for Claude, ChatGPT, Grok, Perplexity, Manus and other clients
- [MCP tool reference](https://docs.penfield.app/mcp/mcp-integration/) covering all 17 tools
- [REST API](https://docs.penfield.app/api/) for custom integrations

## Also available

- **OpenClaw**: [openclaw-penfield](https://github.com/penfieldlabs/openclaw-penfield), a native plugin
- **Hermes**: [hermes-penfield](https://github.com/penfieldlabs/hermes-penfield), a native plugin
- **Claude Code**: [claude-penfield](https://github.com/penfieldlabs/claude-penfield), a plugin (`/plugin marketplace add penfieldlabs/claude-penfield`)

## Links

- Website: [penfield.app](https://penfield.app)
- Portal: [portal.penfield.app](https://portal.penfield.app)
- Docs: [docs.penfield.app](https://docs.penfield.app)
- MCP Registry: `io.github.penfieldlabs/penfield-mcp`
- Glama: [Penfield Memory](https://glama.ai/mcp/connectors/io.github.penfieldlabs/penfield-mcp)
- Cursor Directory: [cursor.directory/plugins/mcp-penfield](https://cursor.directory/plugins/mcp-penfield)
- X: [@penfieldlabs](https://x.com/penfieldlabs)
- Support: support@penfield.app

## Security

To report a security issue, see [SECURITY.md](SECURITY.md).

## License

[AGPL-3.0](LICENSE)
