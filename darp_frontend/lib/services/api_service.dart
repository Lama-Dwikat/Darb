import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/trip_location.dart';

class TripResponse {
  final String tripId;
  final String language;
  final int totalDurationMin;
  final List<TripLocation> itinerary;

  TripResponse({
    required this.tripId,
    required this.language,
    required this.totalDurationMin,
    required this.itinerary,
  });

  factory TripResponse.fromJson(Map<String, dynamic> json) {
    return TripResponse(
      tripId: json['trip_id'] as String,
      language: json['language'] as String,
      totalDurationMin: json['total_duration_min'] as int,
      itinerary: (json['itinerary'] as List<dynamic>)
          .map((e) => TripLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ApiService {
  static const String _tripPath = '/api/trip';

  Future<TripResponse> generateTrip({
    required List<String> interests,
    required int durationMin,
    required String language,
  }) async {
    final uri = Uri.parse('${AppConfig.baseUrl}$_tripPath');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'interests': interests,
        'duration_min': durationMin,
        'language': language,
      }),
    );

    if (response.statusCode == 200) {
      return TripResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    String message = 'Something went wrong. Please try again.';
    try {
      final error = jsonDecode(response.body) as Map<String, dynamic>;
      message = (error['error'] as Map)['message'] as String? ?? message;
    } catch (_) {}

    throw Exception(message);
  }
}
