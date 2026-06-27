---
name: Darb app architecture
description: How the Node.js backend and Flutter frontend are wired together
---

## Rule
Node.js Express server (backend/server.js) on port 5000 serves BOTH:
1. Flutter static build from `darp_frontend/build/web/` via express.static
2. `/api/generateItinerary` POST endpoint calling Gemini

Flutter web uses root-relative `/api/generateItinerary` (same-origin, no CORS issues).

**Why:**
Single-server architecture avoids CORS, simplifies deployment, and works with Replit's port proxying.

**How to apply:**
- Always run `cd darp_frontend && flutter build web` before restarting the server after Flutter code changes.
- Workflow command: `node backend/server.js`
- Never use `flutter run` in production — it conflicts with port 5000.
