# Astro MCP Integration

Integrate an MCP server into an existing Astro project — generates the `/mcp` endpoint with your tools, prompts, and resources, protected by OAuth 2.0 Bearer token authentication.

## Overview

This skill automates the full MCP integration process in an Astro project:

- Explores the existing project (adapter, dependencies, middleware, bindings)
- Installs `@modelcontextprotocol/sdk` and `zod` if not already present
- Generates `src/pages/mcp.ts` with the tools, prompts, and resources you describe
- Sets up `/.well-known/oauth-protected-resource` for MCP client discovery
- Configures Bearer token validation (JWT, opaque token introspection, or local table)
- Updates `astro.config.mjs` with the required `security.checkOrigin: false`

## Installation

```bash
# Using npx
npx skills add jondotsoy/skills --skill astro-mcp-integration

# Using bunx
bunx skills add jondotsoy/skills --skill astro-mcp-integration
```

## Usage

After installing the skill, describe in natural language what you need:

- **Tools** — name, what they do, their input parameters
- **Prompts** — name, description, arguments
- **Resources** — URI, MIME type, what they return

The skill will ask a few OAuth questions (authorization server URL, token validation method, user identifier claim, required scopes) before generating the authentication code.

### Example prompt

```
Integrate an MCP server into my Astro project with:
- A tool called `search_products` that receives a `query` string and returns a list of products
- A resource at `myapp://catalog` that returns the full product catalog as JSON
- Required scope: `mcp`
- Auth server: https://auth.myapp.com (JWT tokens, JWKS at /jwks)
- User claim: `sub`
```

## Generated file structure

```
src/
├── middleware.ts          # /.well-known/oauth-protected-resource
└── pages/
    └── mcp.ts             # MCP handler (POST/GET /mcp)
```

## Generated endpoints

| Endpoint | Description |
|---|---|
| `POST /mcp` | MCP server — JSON-RPC over HTTP |
| `GET /mcp` | MCP server — capability discovery |
| `GET /.well-known/oauth-protected-resource` | OAuth metadata for MCP clients |

## Requirements

- Astro project with SSR enabled (any adapter: Cloudflare, Node, Vercel…)
- An existing OAuth authorization server (Auth0, Clerk, Keycloak, GitHub OAuth, custom…)

The skill does **not** implement the authorization server — only the protected resource side.

## Documentation

- [SKILL.md](SKILL.md) - Skill definition
- [AGENTS.md](AGENTS.md) - Detailed agent instructions

## License

MIT License — See [LICENSE](../LICENSE) for details
