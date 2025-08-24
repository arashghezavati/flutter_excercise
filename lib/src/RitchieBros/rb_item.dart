class RBItem {
  const RBItem({
    required this.assetDescription,
    required this.imageUrl,
    required this.locationCity,
    required this.locationState,
    required this.locationCountry,
    required this.eventAdvertisedName,
    required this.eventStartDate,
    this.itemNumber,
  });

  final String assetDescription;
  final String imageUrl;
  final String locationCity;
  final String locationState;
  final String locationCountry;
  final String eventAdvertisedName;
  final int eventStartDate; // Unix timestamp
  final String? itemNumber;

  // Helper method to format location based on country
  String get formattedLocation {
    if (locationCountry == 'USA') {
      return '$locationCity, $locationState, $locationCountry';
    } else {
      return '$locationCity, $locationCountry';
    }
  }

  // Helper method to format date
  String get formattedEventDate {
    final date = DateTime.fromMillisecondsSinceEpoch(eventStartDate);
    return '${date.day}/${date.month}/${date.year}';
  }

  // Factory constructor to create RBItem from JSON
  factory RBItem.fromJson(Map<String, dynamic> json) {
    return RBItem(
      assetDescription: json['assetDescription'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      locationCity: json['locationCity'] ?? '',
      locationState: json['locationState'] ?? '',
      locationCountry: json['locationCountry'] ?? '',
      eventAdvertisedName: json['eventAdvertisedName'] ?? '',
      eventStartDate: json['eventStartDate'] ?? 0,
      itemNumber: json['itemNumber'],
    );
  }
}
