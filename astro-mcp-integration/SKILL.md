---
name: astro-mcp-integration
description: Integrates an MCP server into an existing Astro project. Generates the /mcp endpoint with tools, prompts, and resources described by the user, with OAuth 2.0 Bearer token authentication.
license: MIT
metadata:
  author: Jonathan Delgado <hi@jon.soy> (https://jon.soy)
  version: "1.0"
compatibility: Requires @modelcontextprotocol/sdk and zod as npm dependencies
---

## Overview

This skill integrates a Model Context Protocol (MCP) server into an existing Astro project. It generates the `/mcp` endpoint and configures OAuth 2.0 Bearer token authentication so that MCP clients can discover and connect to the server securely.

## Expected user arguments

The user must describe in natural language:
- The **tools** they need (name, what they do, their inputs)
- The **prompts** they need (name, description, args)
- The **resources** they need (URI, mimeType, what they return)
- The **docs path** where the MCP documentation file should be generated (default: `docs/MCP.md`)

If the user does not specify any of these, assume empty / use the default and continue.

---

## Step 1 — Explore the project

Read these files to understand the current state before generating any code:

1. `astro.config.mjs` — adapter (Cloudflare, Node, Vercel…)
2. `package.json` — whether `@modelcontextprotocol/sdk` is already installed
3. `src/middleware.ts` — whether middleware already exists
4. `src/pages/mcp.ts` — whether MCP already exists
5. `src/pages/oauth/` — whether the OAuth flow already exists
6. `wrangler.jsonc` (if Cloudflare) — available bindings (D1, KV, etc.)

Share a summary with the user of what you found (what exists and what you will create).

---

## Step 2 — Install dependency if missing

If `@modelcontextprotocol/sdk` is not in `package.json`, install it using the project's
package manager (Bun by default if `bun.lockb` exists; otherwise npm/pnpm/yarn according
to `package-lock.json` / `pnpm-lock.yaml` / `yarn.lock`).

```bash
bun add @modelcontextprotocol/sdk
# or: npm install @modelcontextprotocol/sdk
```

If `zod` is also absent, install it as well (`bun add zod`).

---

## Step 3 — Generate `src/pages/mcp.ts`

Create (or replace) the main MCP handler. The file must follow exactly this pattern,
adapting the tools/prompts/resources content to what the user described:

```typescript
import type { APIRoute } from 'astro';
import { z } from 'zod';
import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { WebStandardStreamableHTTPServerTransport } from '@modelcontextprotocol/sdk/server/webStandardStreamableHttp.js';

export const prerender = false;

// ── Auth helpers ──────────────────────────────────────────────────────────────

function unauthorizedResponse(origin: string, error?: string) {
  const challenge = error
    ? `Bearer realm="${origin}", resource_metadata="${origin}/.well-known/oauth-protected-resource", error="${error}"`
    : `Bearer realm="${origin}", resource_metadata="${origin}/.well-known/oauth-protected-resource"`;
  return new Response('Unauthorized', {
    status: 401,
    headers: { 'WWW-Authenticate': challenge },
  });
}

// ── MCP Server builder ────────────────────────────────────────────────────────

async function buildServer(uid: string, _locale: string | null, _baseUrl: string) {
  const server = new McpServer({
    name: 'mcp-server',
    version: '1.0.0',
  });

  // ── Resources ───────────────────────────────────────────────────────────────
  // server.resource(
  //   'my-resource',
  //   'myapp://my-resource',
  //   { title: 'My Resource', description: '...', mimeType: 'text/plain' },
  //   async (uri) => ({
  //     contents: [{ uri: uri.href, text: 'content here', mimeType: 'text/plain' }],
  //   }),
  // );

  // ── Tools ───────────────────────────────────────────────────────────────────
  // server.registerTool(
  //   'my_tool',
  //   {
  //     title: 'My Tool',
  //     description: '...',
  //     inputSchema: { name: z.string().describe('Example parameter') },
  //   },
  //   async ({ name }) => ({ content: [{ type: 'text', text: `Hello ${name}` }] }),
  // );

  // ── Prompts ─────────────────────────────────────────────────────────────────
  // server.registerPrompt(
  //   'my_prompt',
  //   {
  //     title: 'My Prompt',
  //     description: '...',
  //     argsSchema: { topic: z.string().describe('The topic') },
  //   },
  //   ({ topic }) => ({
  //     messages: [{ role: 'user', content: { type: 'text', text: `Tell me about: ${topic}` } }],
  //   }),
  // );

  return server;
}

// ── Main handler ──────────────────────────────────────────────────────────────

export const ALL: APIRoute = async ({ request }) => {
  const url = new URL(request.url);
  const locale = url.searchParams.get('locale');

  const authHeader = request.headers.get('authorization');
  if (!authHeader?.startsWith('Bearer ')) return unauthorizedResponse(url.origin);
  const token = authHeader.slice(7);

  // Token validation goes here — see Step 4b for each option.
  const uid = ''; // replace with uid obtained from token validation
  if (!uid) return unauthorizedResponse(url.origin, 'invalid_token');

  const server = await buildServer(uid, locale, url.origin);
  if (!server) return unauthorizedResponse(url.origin, 'invalid_token');

  const transport = new WebStandardStreamableHTTPServerTransport({
    sessionIdGenerator: undefined,
    enableJsonResponse: true,
  });
  await server.connect(transport);
  return transport.handleRequest(request);
};
```

**Important when generating the real file:**
- Implement the user's tools/prompts/resources directly (do not leave examples commented out).
- Write **all** `name`, `title`, `description`, `inputSchema` descriptions, and prompt messages in **English** — reduces token usage on every LLM call.
- Complete the Bearer authentication block with real token validation (see Step 4b).
- If the project is on Cloudflare, use `import { env } from 'cloudflare:workers'` to access bindings.

---

## Step 4 — OAuth configuration (protected resource)

This skill **does not implement the authorization server** — that is the user's responsibility;
they can reuse any existing IDP (Auth0, Clerk, Keycloak, GitHub OAuth, a custom implementation, etc.).

Before generating code, **ask the user**:

1. **Authorization server URL** (`issuer`) — e.g. `https://auth.example.com` or the base URL of their IDP.
2. **Bearer token validation mechanism** that the IDP will issue:
   - **A) JWT** — the handler verifies the signature locally with the IDP's public key / JWKS.
   - **B) Opaque token + introspection** — the handler calls the IDP's introspection endpoint on every request.
   - **C) Local table** — the user manages tokens in their own DB (the IDP writes them via webhook or custom flow).
3. **Claim or field** that identifies the user in the token (`sub`, `uid`, custom claim…).
4. **Required scopes** to access the MCP (e.g. `mcp`, `read:data`).

With that information, generate only the **protected resource** files:

### 4a — Middleware `/.well-known/oauth-protected-resource`

This endpoint tells MCP clients where the authorization server is.
The skill only generates **this endpoint**, not `oauth-authorization-server` (that belongs to the user's IDP).

Create or update `src/middleware.ts`:

```typescript
import { defineMiddleware } from 'astro:middleware';

export const onRequest = defineMiddleware(async (context, next) => {
  const { pathname } = context.url;
  const origin = context.url.origin;

  if (pathname === '/.well-known/oauth-protected-resource') {
    return new Response(
      JSON.stringify({
        resource: `${origin}/mcp`,
        authorization_servers: ['<IDP_ISSUER>'],  // URL the user provided
        scopes_supported: ['<SCOPE>'],             // scopes the user provided
      }),
      { headers: { 'content-type': 'application/json' } },
    );
  }

  return next();
});
```

If the middleware already exists, add only the `/.well-known/oauth-protected-resource` block
at the top of `onRequest` without touching the rest.

### 4b — Bearer validation in the MCP handler

Complete the authentication block in `src/pages/mcp.ts` using the option the user indicated:

**Option A — JWT (local signature verification):**
```typescript
import { jwtVerify, createRemoteJWKSet } from 'jose';
const JWKS = createRemoteJWKSet(new URL('<IDP_JWKS_URI>'));
const { payload } = await jwtVerify(token, JWKS, {
  issuer: '<ISSUER>',
  audience: '<AUDIENCE>',
});
const uid = String(payload['<UID_CLAIM>'] ?? payload.sub ?? '');
if (!uid) return unauthorizedResponse(url.origin, 'invalid_token');
```

**Option B — Opaque token with introspection:**
```typescript
const res = await fetch('<IDP_INTROSPECTION_ENDPOINT>', {
  method: 'POST',
  headers: { 'content-type': 'application/x-www-form-urlencoded' },
  body: new URLSearchParams({ token }),
});
const data = await res.json() as { active: boolean; sub?: string };
if (!data.active) return unauthorizedResponse(url.origin, 'invalid_token');
const uid = data.sub ?? '';
```

**Option C — Local token table:**
```typescript
const row = await env.MY_DB.prepare(
  'SELECT uid FROM oauth_tokens WHERE token=?1'
).bind(token).first<{ uid: string }>();
if (!row) return unauthorizedResponse(url.origin, 'invalid_token');
const uid = row.uid;
```

Use only the matching option and remove the others. Replace placeholders with the real
values the user provided.

### 4c — Token table (only if Option C was chosen)

If the user manages tokens in their own DB (Option C) and the project uses Cloudflare D1,
create the migration:

```sql
-- migrations/XXXX_create_oauth_tokens.sql
CREATE TABLE IF NOT EXISTS oauth_tokens (
  token      TEXT PRIMARY KEY,
  uid        TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
```

Name the file with the next available migration number (read the `migrations/` directory
to determine it) and remind the user:

```bash
wrangler d1 migrations apply <DATABASE_NAME> --local  # development
wrangler d1 migrations apply <DATABASE_NAME>           # production
```

---

## Step 5 — Generate documentation file

Create (or replace) the MCP documentation file. The default path is `docs/MCP.md`; use the
path the user specified if they provided one. Create parent directories if they don't exist.

The file must document everything a developer needs to understand and connect to the MCP server:

```markdown
# MCP Server

Brief description of what this MCP server exposes.

## Endpoint

`POST /mcp` — JSON-RPC over HTTP (Bearer token required)

## Authentication

Describe the token validation method (JWT / introspection / local table), the issuer URL,
required scopes, and where to obtain a token.

## Tools

### tool_name
Description of what this tool does.

**Input:**
| Parameter | Type | Description |
|---|---|---|
| param | string | What it is |

**Output:** Description of what the tool returns.

(repeat for each tool)

## Prompts

### prompt_name
Description. Arguments: `arg` — what it means.

(repeat for each prompt)

## Resources

### `myapp://resource-uri`
Description. MIME type: `text/plain`.

(repeat for each resource)

## Integration example

Quick example of calling the MCP server with a Bearer token.
```

**Important when generating the real file:**
- Fill every section with the actual tools, prompts, resources, and OAuth details from this session.
- Keep descriptions concise — this file is read by developers, not by the LLM at runtime.
- If the parent directory does not exist, create it before writing the file.

---

## Step 6 — Update `astro.config.mjs`

If the project uses OAuth (cross-origin requests from OAuth clients), verify that
`checkOrigin` is disabled in Astro (or handled manually with CORS):

```javascript
// astro.config.mjs
export default defineConfig({
  // ...
  security: {
    checkOrigin: false,   // required for external OAuth clients
  },
});
```

If `checkOrigin` is already `false`, do not change anything.

---

## Step 7 — Save definitions to project memory

Append an `## MCP Server` section to the project's `CLAUDE.md` file (create it at the
project root if it doesn't exist) so these definitions persist across sessions and future
agents can update the MCP server without asking the user again.

The section must capture every decision made during this session:

```markdown
## MCP Server

<!-- managed by astro-mcp-integration skill — update this section when the MCP changes -->

- **Handler:** `src/pages/mcp.ts`
- **Docs:** `docs/MCP.md`  <!-- or the path the user specified -->
- **OAuth issuer:** `<ISSUER_URL>`
- **Token validation:** JWT / introspection / local table  <!-- whichever was chosen -->
- **User claim:** `<CLAIM_NAME>`
- **Scopes:** `<SCOPE_LIST>`

### Tools
- `tool_name` — one-line description

### Prompts
- `prompt_name` — one-line description

### Resources
- `myapp://resource-uri` — one-line description
```

Rules:
- If a `## MCP Server` section already exists in `CLAUDE.md`, replace it entirely.
- Do not touch any other section of `CLAUDE.md`.
- Use the actual values from the session — no placeholders.

---

## Step 8 — Final summary to the user

When done, show the user:

1. **Files created/modified** with their relative paths.
2. **Generated endpoints:**
   - `POST/GET /mcp` — MCP server (OAuth Bearer token)
   - `GET /.well-known/oauth-protected-resource` — Protected resource metadata
3. **IDP endpoints** (user's responsibility, not generated by this skill):
   - `GET /.well-known/oauth-authorization-server` (or the IDP's discovery URL)
   - Client registration, authorization, token exchange — according to the chosen IDP
4. **Registered tools** (name and brief description).
5. **Registered prompts**.
6. **Registered resources**.
7. **Documentation** — path of the generated MCP doc file.
8. **Pending steps** the user must complete manually (add real DB logic, update secrets, run migrations, etc.).

---

## Implementation notes

- Keep `export const prerender = false` in all API `.ts` files.
- Use `export const ALL: APIRoute` for the MCP handler (accepts any HTTP method).
- `sessionIdGenerator: undefined` in the transport disables stateful session management (correct for stateless Workers).
- `enableJsonResponse: true` makes the transport use JSON-RPC over HTTP instead of SSE, compatible with most current MCP clients.
- For Cloudflare, the runtime has no `node:crypto`; use `crypto.subtle` (Web Crypto API) directly for hashing.
- If the user implements their own IDP in the same Astro project, they can use the existing `Layout.astro` in their authorization pages.
- Do not duplicate logic: if the project already has hash helpers or JSON response helpers, import them instead of recreating them.
