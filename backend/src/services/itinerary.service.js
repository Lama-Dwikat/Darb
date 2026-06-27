'use strict';

const { randomUUID } = require('crypto');
const { recommend } = require('./recommendationEngine');

function generateItinerary(request) {
  const tripId = randomUUID();

  console.log('[AI] Analyzing preferences...');
  const selected = recommend(request);

  console.log('[AI] Matching attractions...');
  const itinerary = selected.map(place => ({
    id:           place.id,
    name:         place.name,
    category:     place.category,
    duration_min: place.estimated_duration_min,
    score:        place.score,
    description:  place.description,
    location:     place.location,
  }));

  console.log('[AI] Optimizing itinerary...');
  const total_duration_min = itinerary.reduce((sum, s) => sum + s.duration_min, 0);

  console.log(`[AI] Trip generated successfully. ${itinerary.length} stops · ${total_duration_min} min total.`);

  return {
    trip_id:           tripId,
    language:          request.language,
    total_duration_min,
    itinerary,
  };
}

module.exports = { generateItinerary };
