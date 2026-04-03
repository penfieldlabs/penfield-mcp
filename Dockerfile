FROM node:22-slim
ENTRYPOINT ["npx", "-y", "mcp-remote", "https://mcp.penfield.app/"]
