function errorResponse(status, message, details = null) {
  const body = { error: { status, message } };
  if (details) body.error.details = details;
  return { status, jsonBody: body };
}

function badRequest(message, details = null) {
  return errorResponse(400, message, details);
}

function internalServerError(message = 'An unexpected error occurred') {
  return errorResponse(500, message);
}

module.exports = { errorResponse, badRequest, internalServerError };
