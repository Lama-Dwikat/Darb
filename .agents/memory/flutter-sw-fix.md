---
name: Flutter stale service worker fix
description: Clearing debug-mode service worker when switching to production build
---

## Rule
When `flutter run` (debug) is replaced by `flutter build web` + Node.js serving, the browser caches the debug service worker which tries to load `web_entrypoint.dart`. This causes a blank white page.

**Fix:** Add this to `darp_frontend/web/index.html` before `<body>`:
```html
<script>
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.getRegistrations().then(function(registrations) {
      for (var reg of registrations) { reg.unregister(); }
    });
  }
</script>
```

**Why:** The debug SW caches requirejs-based module loading which doesn't exist in the production build. Unregistering all SWs on load lets the new production SW install cleanly.

**How to apply:** This is already in `darp_frontend/web/index.html`. It persists across `flutter build web` runs since it's in the source `web/` folder, not the build output.
