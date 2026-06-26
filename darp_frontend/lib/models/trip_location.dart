class TripLocation {
  final String name;
  final String duration;

  const TripLocation({
    required this.name,
    required this.duration,
  });

  factory TripLocation.fromJson(Map<String, dynamic> json) {
    return TripLocation(
      name: json['name'] as String,
      duration: '${json['duration_min']} min',
    );
  }
}