const { badRequest } = require('../utils/errorResponse');

function validateTripRequest(body) {
  if (!body.interests) {
    return badRequest('interests is required');
  }
  if (!Array.isArray(body.interests)) {
    return badRequest('interests must be an array');
  }
  if (body.duration_min === undefined || body.duration_min === null) {
    return badRequest('duration_min is required');
  }
  if (typeof body.duration_min !== 'number' || body.duration_min <= 0) {
    return badRequest('duration_min must be a positive number');
  }
  if (!body.language) {
    return badRequest('language is required');
  }
  return null;
}

module.exports = { validateTripRequest };
