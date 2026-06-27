const { GoogleGenAI } = require('@google/genai');

const MODEL = 'gemini-2.5-flash';

let _client = null;

function getClient() {
  if (_client) return _client;

  const apiKey = process.env.GEMINI_API_KEY;
  if (!apiKey) {
    throw new Error('GEMINI_API_KEY is not set.');
  }

  _client = new GoogleGenAI({ apiKey });
  return _client;
}

function buildSystemMessage() {
  return (
    'You are a Palestinian cultural tourism expert. ' +
    'You respond only with valid JSON. No markdown, no code fences, no explanation. ' +
    'Your JSON must be a single object with one key "itinerary" whose value is an array of stops.'
  );
}

function buildUserMessage(request) {
  const { interests, duration_min, language } = request;
  const interestsList = interests.join(', ');

  return (
    `Generate a tourist itinerary for a visitor with these interests: ${interestsList}.\n` +
    `Total available time: ${duration_min} minutes.\n` +
    `All text fields (name, description) must be written in: ${language}.\n\n` +
    `Return a JSON object in exactly this format — nothing else:\n` +
    `{\n` +
    `  "itinerary": [\n` +
    `    {\n` +
    `      "stop_id": "stop_1",\n` +
    `      "name": "<site name in ${language}>",\n` +
    `      "description": "<1-2 sentence description in ${language}>",\n` +
    `      "duration_min": <integer>,\n` +
    `      "category": "<one of: Religious, Historical, Cultural, Nature, Market>"\n` +
    `    }\n` +
    `  ]\n` +
    `}\n\n` +
    `Rules:\n` +
    `- The sum of all duration_min values must equal exactly ${duration_min}.\n` +
    `- Include between 2 and 6 stops.\n` +
    `- Focus on real Palestinian heritage sites.\n` +
    `- stop_id values must be unique strings like "stop_1", "stop_2", etc.\n` +
    `- Output only the JSON object, nothing else.`
  );
}

function parseResponse(content) {
  const cleaned = content
    .replace(/```(?:json)?/gi, '')
    .replace(/```/g, '')
    .trim();

  let parsed;
  try {
    parsed = JSON.parse(cleaned);
  } catch {
    throw new Error(`Gemini returned malformed JSON: ${cleaned.slice(0, 200)}`);
  }

  if (Array.isArray(parsed)) return parsed;
  if (Array.isArray(parsed.itinerary)) return parsed.itinerary;

  throw new Error('Gemini response did not contain an itinerary array.');
}

async function generateItineraryItems(request) {
  const client = getClient();

  const response = await client.models.generateContent({
    model: MODEL,
    contents: buildUserMessage(request),
    config: {
      systemInstruction: buildSystemMessage(),
      responseMimeType: 'application/json',
    },
  });

  const content = response.text;
  if (!content) {
    throw new Error('Gemini returned an empty response.');
  }

  return parseResponse(content);
}

module.exports = { generateItineraryItems };
