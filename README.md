# Risk Tower Platform

Version `1.0.0`

Risk Tower is a local/on-prem cyber risk operations platform for:

- dashboard reporting
- asset inventory
- vulnerability import
- compliance import
- risk scoring and summaries
- remediation workflow
- governance and approvals
- audit logging
- role-based access control

This repository is prepared for a clean `v1.0.0` local release package. The release baseline contains no testing assets, no testing scan data, and only one default account:

- Username: `admin`
- Password: `admin`

## Quick Start

### Docker

```powershell
copy .env.example .env
docker compose up --build -d
```

Open:

```text
http://127.0.0.1:4100
```

### Local Node.js

```powershell
npm ci
.\scripts\start-local.ps1
```

## Default Local Security Profile

- `TI_DEPLOYMENT_PROFILE=local`
- `TI_AUTH_MODE=local-only`
- localhost-only origin and host checks
- login lockout after repeated failed attempts
- idle session timeout
- absolute session lifetime
- CSP, HSTS, no-store API responses, and audit logging

## Release Output

The curated customer handoff package is generated under:

```text
release\risk-tower-v1.0.0
```

It includes:

- clean seed database
- local and Docker deployment files
- startup scripts
- release user manual

## Verification

```powershell
npm run check
npm test
npm run build
```

## Main Docs

- `docs\local\LOCAL_DEPLOYMENT.md`
- `docs\local\SERVER_START_RESTART_GUIDE.md`
- `docs\security\OWASP_TOP_10_HARDENING.md`
