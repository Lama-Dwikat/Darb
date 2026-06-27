class TripLocation {
  final String name;
  final String duration;
  final String description;
  final String category;
  final String? imageUrl;

  const TripLocation({
    required this.name,
    required this.duration,
    this.description = '',
    this.category = '',
    this.imageUrl,
  });

  factory TripLocation.fromJson(Map<String, dynamic> json) {
    return TripLocation(
      name: json['name'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
