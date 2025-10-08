class Bungalow {
  final String id;
  final String title;
  final String description;
  final String location;
  final String city;
  final double price;
  final int capacity;
  final int size;
  final List<String> images;
  final List<String> amenities;
  final bool hasPool;
  final bool hasJacuzzi;
  final bool hasWifi;
  final bool hasParking;
  final double rating;
  final int reviewCount;
  final String ownerId;
  final DateTime createdAt;
  final bool isAvailable;

  Bungalow({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.city,
    required this.price,
    required this.capacity,
    required this.size,
    required this.images,
    required this.amenities,
    this.hasPool = false,
    this.hasJacuzzi = false,
    this.hasWifi = true,
    this.hasParking = true,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.ownerId,
    required this.createdAt,
    this.isAvailable = true,
  });

  factory Bungalow.fromJson(Map<String, dynamic> json) {
    return Bungalow(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      city: json['city'],
      price: json['price'].toDouble(),
      capacity: json['capacity'],
      size: json['size'],
      images: List<String>.from(json['images']),
      amenities: List<String>.from(json['amenities']),
      hasPool: json['hasPool'] ?? false,
      hasJacuzzi: json['hasJacuzzi'] ?? false,
      hasWifi: json['hasWifi'] ?? true,
      hasParking: json['hasParking'] ?? true,
      rating: json['rating']?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      ownerId: json['ownerId'],
      createdAt: DateTime.parse(json['createdAt']),
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'city': city,
      'price': price,
      'capacity': capacity,
      'size': size,
      'images': images,
      'amenities': amenities,
      'hasPool': hasPool,
      'hasJacuzzi': hasJacuzzi,
      'hasWifi': hasWifi,
      'hasParking': hasParking,
      'rating': rating,
      'reviewCount': reviewCount,
      'ownerId': ownerId,
      'createdAt': createdAt.toIso8601String(),
      'isAvailable': isAvailable,
    };
  }
} 