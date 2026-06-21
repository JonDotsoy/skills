---
name: astro-mcp-integration
description: Integrates an MCP server into an existing Astro project. Generates the /mcp endpoint with tools, prompts, and resources described by the user, with OAuth 2.0 Bearer token authentication.
license: MIT
metadata:
  author: Jonathan Delgado <hi@jon.soy> (https://jon.soy)
  version: "1.0"
dependencies: "@modelcontextprotocol/sdk>=1.0.0, zod>=3.0.0"
---

## Overview

This skill integrates a Model Context Protocol (MCP) server into an existing Astro project. It generates the `/mcp` endpoint and configures OAuth 2.0 Bearer token authentication so that MCP clients can discover and connect to the server securely.

The skill handles:
- Exploring the existing project to understand its adapter and structure
- Installing `@modelcontextprotocol/sdk` and `zod` if missing
- Generating `src/pages/mcp.ts` with the tools, prompts, and resources the user describes
- Setting up `/.well-known/oauth-protected-resource` for MCP client discovery
- Configuring Bearer token validation (JWT, token introspection, or local table)

**For complete step-by-step implementation guidance, read [AGENTS.md](AGENTS.md).**

## Instructions

1. **Ask the user** what tools, prompts, and resources they need in their MCP server. If they don't specify some, assume empty and continue.

2. **Explore the project** — read `astro.config.mjs`, `package.json`, `src/middleware.ts`, `src/pages/mcp.ts`, `src/pages/oauth/`, and (if Cloudflare) `wrangler.jsonc`. Share a summary of what exists and what you will create.

3. **Install dependencies** — if `@modelcontextprotocol/sdk` or `zod` are missing, install them using the project's package manager (Bun if `bun.lockb` exists, otherwise npm/pnpm/yarn).

4. **Generate `src/pages/mcp.ts`** — follow the pattern in AGENTS.md, implementing the user's tools, prompts, and resources. All names, titles, descriptions, and prompt messages must be written in English.

5. **Ask OAuth questions** before generating auth code:
   - Authorization server URL (issuer)
   - Token validation method: JWT local verification, token introspection, or local DB table
   - User identifier claim (`sub`, `uid`, custom claim)
   - Required scopes

6. **Generate OAuth files** — `src/middleware.ts` with `/.well-known/oauth-protected-resource`, and complete the Bearer token validation block in `mcp.ts`.

7. **Update `astro.config.mjs`** — set `security.checkOrigin: false` if not already set.

8. **Provide a final summary** — files created, endpoints generated, tools/prompts/resources registered, and pending manual steps.
