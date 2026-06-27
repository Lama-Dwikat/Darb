---
name: Gemini model selection for Darb
description: Which Gemini model names work with this project's API key
---

## Rule
Use `gemini-2.5-flash` in backend/server.js.

**Why:**
- `gemini-1.5-flash` and `gemini-1.5-flash-latest` → 404 on v1beta endpoint (used by @google/generative-ai v0.21.0)
- `gemini-2.0-flash` → 429 free-tier quota exhausted (limit: 0)  
- `gemini-2.5-flash` → works, confirmed returning valid JSON

**How to apply:**
Any time the Gemini model name is changed or the @google/generative-ai package is updated, test with a simple generateContent call before deploying.
