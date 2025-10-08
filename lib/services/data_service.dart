import '../models/bungalow.dart';
import '../models/user.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  // Sample bungalow data
  List<Bungalow> getSampleBungalows() {
    return [
      Bungalow(
        id: '1',
        title: 'Sapanca Göl Kenarı Bungalov',
        description: 'Sapanca Gölü\'nün muhteşem manzarasına sahip, doğayla iç içe bungalov. Modern tasarım ve konforlu yaşam alanları.',
        location: 'Sapanca, Sakarya',
        city: 'Sapanca',
        price: 1200.0,
        capacity: 4,
        size: 80,
        images: [
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=800&q=80',
        ],
        amenities: ['WiFi', 'Parking', 'Kitchen', 'Balcony', 'Lake View'],
        hasPool: false,
        hasJacuzzi: true,
        hasWifi: true,
        hasParking: true,
        rating: 4.8,
        reviewCount: 24,
        ownerId: 'owner1',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        isAvailable: true,
      ),
      Bungalow(
        id: '2',
        title: 'Abant Dağ Evi',
        description: 'Abant Gölü yakınlarında, dağ havası ve temiz oksijen eşliğinde huzurlu bir tatil deneyimi.',
        location: 'Abant, Bolu',
        city: 'Abant',
        price: 1800.0,
        capacity: 6,
        size: 120,
        images: [
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=800&q=80',
        ],
        amenities: ['WiFi', 'Parking', 'Pool', 'BBQ', 'Mountain View'],
        hasPool: true,
        hasJacuzzi: true,
        hasWifi: true,
        hasParking: true,
        rating: 4.9,
        reviewCount: 18,
        ownerId: 'owner2',
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
        isAvailable: true,
      ),
      Bungalow(
        id: '3',
        title: 'Ağva Orman Bungalovu',
        description: 'İstanbul\'a yakın, ormanın içinde, şelale sesleri eşliğinde unutulmaz bir deneyim.',
        location: 'Ağva, İstanbul',
        city: 'Ağva',
        price: 1500.0,
        capacity: 4,
        size: 90,
        images: [
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
        ],
        amenities: ['WiFi', 'Parking', 'Forest View', 'River Access', 'Hiking Trails'],
        hasPool: false,
        hasJacuzzi: false,
        hasWifi: true,
        hasParking: true,
        rating: 4.7,
        reviewCount: 31,
        ownerId: 'owner3',
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
        isAvailable: true,
      ),
      Bungalow(
        id: '4',
        title: 'Fethiye Villa Bungalov',
        description: 'Fethiye\'nin muhteşem koylarında, deniz manzarasına sahip lüks bungalov.',
        location: 'Fethiye, Muğla',
        city: 'Fethiye',
        price: 2500.0,
        capacity: 8,
        size: 150,
        images: [
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=800&q=80',
        ],
        amenities: ['WiFi', 'Parking', 'Pool', 'Jacuzzi', 'Sea View', 'Private Beach'],
        hasPool: true,
        hasJacuzzi: true,
        hasWifi: true,
        hasParking: true,
        rating: 4.9,
        reviewCount: 42,
        ownerId: 'owner4',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        isAvailable: true,
      ),
      Bungalow(
        id: '5',
        title: 'Kartepe Kayak Evi',
        description: 'Kartepe\'de kayak sezonunda mükemmel konumda, kar manzarasına sahip bungalov.',
        location: 'Kartepe, Kocaeli',
        city: 'Kartepe',
        price: 2000.0,
        capacity: 6,
        size: 100,
        images: [
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
        ],
        amenities: ['WiFi', 'Parking', 'Ski Storage', 'Mountain View', 'Fireplace'],
        hasPool: false,
        hasJacuzzi: true,
        hasWifi: true,
        hasParking: true,
        rating: 4.6,
        reviewCount: 15,
        ownerId: 'owner5',
        createdAt: DateTime.now().subtract(const Duration(days: 75)),
        isAvailable: true,
      ),
    ];
  }

  // Sample popular locations
  List<String> getPopularLocations() {
    return [
      'Sapanca',
      'Abant',
      'Ağva',
      'Fethiye',
      'Kartepe',
      'Uludağ',
      'Kaz Dağları',
      'Kapadokya',
    ];
  }

  // Sample user data
  User getSampleUser() {
    return User(
      id: 'user1',
      email: 'user@example.com',
      name: 'Ahmet Yılmaz',
      phone: '+90 555 123 4567',
      role: UserRole.user,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      isVerified: true,
    );
  }

  // Get bungalow by ID
  Bungalow? getBungalowById(String id) {
    try {
      return getSampleBungalows().firstWhere((bungalow) => bungalow.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search bungalows by location
  List<Bungalow> searchBungalows(String query) {
    final bungalows = getSampleBungalows();
    if (query.isEmpty) return bungalows;
    
    return bungalows.where((bungalow) {
      return bungalow.title.toLowerCase().contains(query.toLowerCase()) ||
             bungalow.location.toLowerCase().contains(query.toLowerCase()) ||
             bungalow.city.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Filter bungalows by price range
  List<Bungalow> filterByPriceRange(List<Bungalow> bungalows, double minPrice, double maxPrice) {
    return bungalows.where((bungalow) {
      return bungalow.price >= minPrice && bungalow.price <= maxPrice;
    }).toList();
  }

  // Filter bungalows by capacity
  List<Bungalow> filterByCapacity(List<Bungalow> bungalows, int capacity) {
    return bungalows.where((bungalow) {
      return bungalow.capacity >= capacity;
    }).toList();
  }

  // Filter bungalows by amenities
  List<Bungalow> filterByAmenities(List<Bungalow> bungalows, List<String> amenities) {
    return bungalows.where((bungalow) {
      for (String amenity in amenities) {
        if (amenity == 'pool' && !bungalow.hasPool) return false;
        if (amenity == 'jacuzzi' && !bungalow.hasJacuzzi) return false;
        if (amenity == 'wifi' && !bungalow.hasWifi) return false;
        if (amenity == 'parking' && !bungalow.hasParking) return false;
      }
      return true;
    }).toList();
  }
} 