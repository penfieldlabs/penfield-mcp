# Penfield MCP Server Installation Guide

Instructions for AI agents (such as Cline) setting up Penfield for a user.

Penfield is a **hosted** MCP server. Nothing is installed locally: the user's MCP client connects to `https://mcp.penfield.app` and the user signs in through OAuth in the browser.

## Prerequisites

- A Penfield account. If the user doesn't have one, send them to https://portal.penfield.app/sign-up first.

## Steps

1. Add Penfield to the client's MCP configuration as a remote server:

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

   Key names vary by client. Use the client's format for remote (streamable HTTP) MCP servers. Do not add an API key or headers: authentication is OAuth, and the client registers itself automatically.

2. If the client can only start local (stdio) servers, or can't do OAuth sign-in for remote servers, use `mcp-remote` instead. This needs Node.js LTS:

   ```json
   {
     "mcpServers": {
       "penfield": {
         "command": "npx",
         "args": ["-y", "mcp-remote", "https://mcp.penfield.app/"]
       }
     }
   }
   ```

3. Restart or reload the client. A browser window opens for Penfield sign-in. Ask the user to sign in and click **Authorize**.

4. Verify by calling the `awaken` tool. It returns the user's Penfield briefing.

## More help

- Setup guides for each client: https://docs.penfield.app/onboarding/
- Tool reference: https://docs.penfield.app/mcp/mcp-integration/
- Support: support@penfield.app
