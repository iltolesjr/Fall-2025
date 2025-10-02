# Auth0 Management API – Quick Start Notes

Base Management API URL (tenant-specific):

```text
https://dev-j7di771swz4qglr3.us.auth0.com/api/v2/
```

## 1. What This Endpoint Is

This is the Auth0 Management API base. All operations (users, clients, connections, roles, logs) append paths, e.g.:

- `GET /api/v2/users`
- `GET /api/v2/clients`
- `GET /api/v2/roles`

It requires a valid machine-to-machine (M2M) access token (not an end-user ID token) with the appropriate scopes.

## 2. Obtain a Management API Token

You create (or use) a Machine-to-Machine Application in Auth0 authorized for the "Auth0 Management API" and request scopes.

Token request (Client Credentials Grant):

```http
POST https://dev-j7di771swz4qglr3.us.auth0.com/oauth/token
Content-Type: application/json

{
  "client_id": "YOUR_CLIENT_ID",
  "client_secret": "YOUR_CLIENT_SECRET",
  "audience": "https://dev-j7di771swz4qglr3.us.auth0.com/api/v2/",
  "grant_type": "client_credentials"
}
```

Response contains `access_token`, `token_type` (Bearer), and `expires_in`.

## 3. Common Scopes (Request Only What You Need)

| Scope | Purpose |
|-------|---------|
| `read:users` | List/get users |
| `update:users` | Patch user profiles |
| `delete:users` | Delete users |
| `create:users` | Create users |
| `read:roles` | List roles |
| `create:roles` | Create roles |
| `read:logs` | Retrieve tenant logs |
| `read:clients` | List applications |

Never over-grant; principle of least privilege.

## 4. Example: List Users

```http
GET https://dev-j7di771swz4qglr3.us.auth0.com/api/v2/users?page=0&per_page=50
Authorization: Bearer YOUR_MANAGEMENT_TOKEN
```

## 5. Example curl Flow

```bash
# 1. Get token
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"client_id":"'$CLIENT_ID'","client_secret":"'$CLIENT_SECRET'","audience":"https://dev-j7di771swz4qglr3.us.auth0.com/api/v2/","grant_type":"client_credentials"}' \
  https://dev-j7di771swz4qglr3.us.auth0.com/oauth/token | jq -r .access_token > token.txt

# 2. Use token
TOKEN=$(cat token.txt)
curl -H "Authorization: Bearer $TOKEN" \
  "https://dev-j7di771swz4qglr3.us.auth0.com/api/v2/users?page=0&per_page=5"
```

## 6. Rate Limits / Cautions

- Management API has rate limits; batch responsibly.
- Do not embed Management API calls in client-side (public) code.
- Rotate client secrets if exposed.

## 7. Storing Secrets Safely

Create a local `.env` (not committed) with:

```dotenv
AUTH0_DOMAIN=dev-j7di771swz4qglr3.us.auth0.com
AUTH0_AUDIENCE=https://dev-j7di771swz4qglr3.us.auth0.com/api/v2/
AUTH0_CLIENT_ID=...
AUTH0_CLIENT_SECRET=...
```

Add to `.gitignore`:

```gitignore
.env
```

## 8. Minimal Node Fetch Example

```javascript
import fetch from 'node-fetch';
import 'dotenv/config';

async function getToken() {
  const res = await fetch(`https://${process.env.AUTH0_DOMAIN}/oauth/token`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      client_id: process.env.AUTH0_CLIENT_ID,
      client_secret: process.env.AUTH0_CLIENT_SECRET,
      audience: process.env.AUTH0_AUDIENCE,
      grant_type: 'client_credentials'
    })
  });
  if (!res.ok) throw new Error('Token error');
  return res.json();
}

async function listUsers() {
  const { access_token } = await getToken();
  const res = await fetch(`https://${process.env.AUTH0_DOMAIN}/api/v2/users?per_page=5`, {
    headers: { Authorization: `Bearer ${access_token}` }
  });
  return res.json();
}

listUsers().then(console.log).catch(console.error);
```

## 9. Security Reminders

- Never commit `client_secret`.
- Restrict which IPs can call your backend if possible.
- Periodically rotate credentials.

## 10. Next Possible Integrations

- Add a script to sync Auth0 users into a local markdown roster.
- Add a management script to create roles and assign them.
- Build a thin wrapper endpoint in `.mcp/server.js` that proxies authorized queries (secure with an internal token first).

---

Created: 2025-10-02
