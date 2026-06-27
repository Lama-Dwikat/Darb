const { app } = require("@azure/functions");
const { validateTripRequest } = require("../validators/tripRequest.validator");
const { generateItinerary } = require("../services/itinerary.service");

app.http("trip", {
  methods: ["POST"],
  authLevel: "anonymous",

  handler: async (request, context) => {
    context.log("Trip endpoint called");

    const body = await request.json();
    context.log("Request body received:", JSON.stringify(body));

    const validationError = validateTripRequest(body);
    if (validationError) {
      context.log("Validation failed:", validationError.jsonBody.error.message);
      return validationError;
    }

    const itinerary = await generateItinerary(body);
    context.log("Itinerary generated for trip:", itinerary.trip_id);

    return { jsonBody: itinerary };
  },
});
