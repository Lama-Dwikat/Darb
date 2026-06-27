const express = require('express');
const cors = require('cors');
const path = require('path');
const { GoogleGenerativeAI } = require('@google/generative-ai');

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors({ origin: '*' }));
app.use(express.json());

// Serve Flutter web build (static files)
const flutterBuildPath = path.join(__dirname, '../darp_frontend/build/web');
app.use(express.static(flutterBuildPath));

// POST /api/generateItinerary
app.post('/api/generateItinerary', async (req, res) => {
  try {
    const apiKey = process.env.GEMINI_API_KEY;
    if (!apiKey) {
      return res.status(500).json({ error: 'GEMINI_API_KEY is not configured on the server.' });
    }

    const { language = 'English', interests = [], duration = '2h 0m' } = req.body;

    const genAI = new GoogleGenerativeAI(apiKey);
    const model = genAI.getGenerativeModel({
      model: 'gemini-2.5-flash',
      generationConfig: {
        responseMimeType: 'application/json',
      },
    });

    const interestsText = interests.length > 0 ? interests.join(', ') : 'Historical, Cultural';

    const prompt = `You are a professional tourism guide for Palestine. Generate a personalized trip itinerary.

User preferences:
- Language: ${language} (write ALL text content — titles, names, descriptions — in ${language})
- Interests: ${interestsText}
- Available time: ${duration}

Return ONLY a valid JSON object matching this exact schema (no markdown, no code blocks, no extra text):

{
  "title": "string — creative trip title in ${language}",
  "totalDuration": "${duration}",
  "locations": [
    {
      "name": "string — real site name in ${language}",
      "duration": "string — e.g. '30 min'",
      "description": "string — 2 to 3 sentences about this site in ${language}, include historical or cultural context",
      "category": "string — one of: Religious, Historical, Cultural",
      "imageUrl": null
    }
  ]
}

Rules:
- Include between 3 and 6 locations
- Every location must be a real, verifiable site in Palestine (Jerusalem, Bethlehem, Hebron, Jericho, Ramallah, Nablus, Nazareth, etc.)
- Filter locations to match the user interests: ${interestsText}
- Individual location durations must be realistic (15 to 90 minutes each)
- The sum of all location durations must fit within ${duration}
- Write ALL text (title, name, description) in ${language}
- Return valid JSON only — no markdown fences, no extra keys`;

    const result = await model.generateContent(prompt);
    const text = result.response.text();

    let itinerary;
    try {
      itinerary = JSON.parse(text);
    } catch (_) {
      const match = text.match(/\{[\s\S]*\}/);
      if (match) {
        itinerary = JSON.parse(match[0]);
      } else {
        throw new Error('Gemini returned a response that could not be parsed as JSON.');
      }
    }

    if (!itinerary.locations || !Array.isArray(itinerary.locations)) {
      throw new Error('Gemini response is missing the locations array.');
    }

    return res.json(itinerary);
  } catch (err) {
    console.error('[generateItinerary] Error:', err.message);
    return res.status(500).json({ error: err.message || 'Failed to generate itinerary.' });
  }
});

// Health check
app.get('/api/health', (_req, res) => {
  res.json({ status: 'ok', geminiConfigured: !!process.env.GEMINI_API_KEY });
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
  console.log(`  Gemini: ${process.env.GEMINI_API_KEY ? 'configured' : 'NOT configured — set GEMINI_API_KEY'}\n`);
});
