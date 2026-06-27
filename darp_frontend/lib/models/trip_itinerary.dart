import 'trip_location.dart';

class TripItinerary {
  final String title;
  final String totalDuration;
  final List<TripLocation> locations;

  const TripItinerary({
    required this.title,
    required this.totalDuration,
    required this.locations,
  });

  factory TripItinerary.fromJson(Map<String, dynamic> json) {
    final raw = json['locations'];
    final locationsList = raw is List ? raw : <dynamic>[];
    return TripItinerary(
      title: json['title'] as String? ?? 'Your Journey',
      totalDuration: json['totalDuration'] as String? ?? '',
      locations: locationsList
          .whereType<Map<String, dynamic>>()
          .map(TripLocation.fromJson)
          .toList(),
    );
  }
}
