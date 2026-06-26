const { randomUUID } = require('crypto');

/**
 * Generates a trip itinerary based on the request.
 * Currently returns static mock data.
 * TODO: Replace with Azure OpenAI call.
 *
 * @param {import('../models/tripRequest.model').TripRequest} request
 * @returns {import('../models/tripResponse.model').TripResponse}
 */
async function generateItinerary(request) {
  const tripId = randomUUID();

  return {
    trip_id: tripId,
    language: request.language,
    total_duration_min: request.duration_min,
    itinerary: [],
  };
}

module.exports = { generateItinerary };
