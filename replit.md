# Darb - Personalized Trip Planner

A Flutter web application for personalized tourism trip planning, focused on historical and cultural sites in Palestine (Jerusalem, Bethlehem).

## Project Structure

- `darp_frontend/` — Flutter project root
  - `lib/` — Dart source code
    - `main.dart` — App entry point and route definitions
    - `Screens/` — UI screens (Splash, Welcome, Preferences, Loading, Trip, SiteDetails)
    - `models/` — Data models (TripLocation, TripPreferences)
    - `widgets/` — Reusable UI components (LocationCard)
    - `theme/` — App theme and color constants
  - `assets/images/` — Image assets (Darb_logo.png)
  - `web/` — Flutter web scaffold files
  - `build/web/` — Built web output (generated)

## Tech Stack

- **Language:** Dart
- **Framework:** Flutter 3.32.0 (web target)
- **Package Manager:** pub (flutter pub)

## Running the App

The app runs in Flutter web dev mode:

```
cd darp_frontend && flutter run -d web-server --web-port=5000 --web-hostname=0.0.0.0
```

## Deployment

Configured as a **static site** deployment:
- Build command: `cd darp_frontend && flutter build web`
- Public directory: `darp_frontend/build/web`

## User Preferences

- Keep all Flutter/Dart code under `darp_frontend/`
- Assets live under `darp_frontend/assets/`
