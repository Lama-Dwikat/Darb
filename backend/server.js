const express = require('express');
const cors = require('cors');
const path = require('path');
const { recommendItinerary } = require('./services/recommendationService');

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors({ origin: '*' }));
app.use(express.json());

// Serve Flutter web build (static files)
const flutterBuildPath = path.join(__dirname, '../darp_frontend/build/web');
app.use(express.static(flutterBuildPath));

// POST /api/generateItinerary
// Contract is unchanged: { language, interests, duration } -> { title, totalDuration, locations }
// The itinerary now comes from the local rule-based Recommendation Service
// (Flutter -> Backend API -> Recommendation Service -> sites.json).
app.post('/api/generateItinerary', (req, res) => {
  try {
    const body = req.body || {};
    const { language = 'English', interests = [], duration = '2h 0m' } = body;

    const itinerary = recommendItinerary({ language, interests, duration });

    if (!itinerary.locations || itinerary.locations.length === 0) {
      return res
        .status(404)
        .json({ error: 'No matching locations found for the selected preferences.' });
    }

    return res.json(itinerary);
  } catch (err) {
    console.error('[generateItinerary] Error:', err.message);
    return res.status(500).json({ error: err.message || 'Failed to generate itinerary.' });
  }
});

// Health check
app.get('/api/health', (_req, res) => {
  res.json({ status: 'ok', engine: 'local-recommendation' });
});

// Catch-all: serve Flutter web app for all non-API routes
app.get('*', (_req, res) => {
  res.sendFile(path.join(flutterBuildPath, 'index.html'));
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`\nDarb server running on port ${PORT}`);
  console.log(`  App:    http://0.0.0.0:${PORT}`);
  console.log(`  API:    http://0.0.0.0:${PORT}/api/generateItinerary`);
  console.log(`  Health: http://0.0.0.0:${PORT}/api/health`);
  console.log(`  Engine: local rule-based recommendation (data/sites.json)\n`);
});
