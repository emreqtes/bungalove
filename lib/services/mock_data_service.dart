import '../models/bungalow.dart';
import '../models/user.dart';
import '../models/review.dart';
import '../models/reservation.dart';

class MockDataService {
  // Demo kullanıcılar
  static final List<User> demoUsers = [
    User(
      id: '1',
      email: 'demo@bungalove.com',
      name: 'Demo Kullanıcı',
      phone: '+90 555 123 4567',
      profileImage: 'https://via.placeholder.com/150',
      role: UserRole.user,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      isVerified: true,
    ),
    User(
      id: '2',
      email: 'owner@bungalove.com',
      name: 'Mal Sahibi',
      phone: '+90 555 987 6543',
      profileImage: 'https://via.placeholder.com/150',
      role: UserRole.owner,
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      isVerified: true,
    ),
  ];

  // Demo bungalovlar
  static final List<Bungalow> demoBungalows = [
    Bungalow(
      id: '1',
      title: 'Deniz Manzaralı Lüks Bungalov - Bodrum',
      description: 'Bodrum\'un en güzel koylarından birinde, deniz manzaralı lüks bungalov. Özel plajı ve infinity havuzu ile unutulmaz bir tatil deneyimi.',
      location: 'Bodrum, Muğla',
      city: 'Bodrum',
      price: 2500,
      capacity: 4,
      size: 120,
      amenities: ['WiFi', 'Havuz', 'Deniz Manzarası', 'Klima', 'Parking', 'Mutfak'],
      images: [
        'https://images.unsplash.com/photo-1520637836862-4d197d17c5a2?w=800',
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
      ],
      hasPool: true,
      hasJacuzzi: true,
      hasWifi: true,
      hasParking: true,
      rating: 4.8,
      reviewCount: 24,
      ownerId: '2',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
    ),
    Bungalow(
      id: '2',
      title: 'Doğa İçinde Rustik Bungalov - Kaş',
      description: 'Kaş\'ın doğal güzelliklerinin ortasında, tamamen ahşap yapılmış rustik bungalov. Şehir hayatından uzaklaşmak için ideal.',
      location: 'Kaş, Antalya',
      city: 'Kaş',
      price: 1800,
      capacity: 3,
      size: 80,
      amenities: ['WiFi', 'Şömine', 'Doğa Manzarası', 'Barbekü', 'Bahçe'],
      images: [
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
        'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800',
      ],
      hasPool: false,
      hasJacuzzi: false,
      hasWifi: true,
      hasParking: true,
      rating: 4.6,
      reviewCount: 18,
      ownerId: '2',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 120)),
    ),
    Bungalow(
      id: '3',
      title: 'Aile Dostu Bungalov - Antalya',
      description: 'Antalya\'da aileler için özel tasarlanmış, geniş bahçeli bungalov. Çocuk oyun alanı ve güvenli ortam.',
      location: 'Antalya Merkez',
      city: 'Antalya',
      price: 1200,
      capacity: 6,
      size: 150,
      amenities: ['WiFi', 'Havuz', 'Çocuk Oyun Alanı', 'Bahçe', 'Parking', 'Mutfak', 'Çamaşır Makinesi'],
      images: [
        'https://images.unsplash.com/photo-1582268611958-ebfd161ef9cf?w=800',
        'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
      ],
      hasPool: true,
      hasJacuzzi: false,
      hasWifi: true,
      hasParking: true,
      rating: 4.4,
      reviewCount: 32,
      ownerId: '2',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
    ),
    Bungalow(
      id: '4',
      title: 'Romantik Çift Bungalovu - Çeşme',
      description: 'Çeşme\'de çiftler için özel tasarlanmış romantik bungalov. Özel jakuzi ve şarap terası ile unutulmaz anlar.',
      location: 'Çeşme, İzmir',
      city: 'Çeşme',
      price: 3200,
      capacity: 2,
      size: 60,
      amenities: ['WiFi', 'Jakuzi', 'Şarap Terası', 'Deniz Manzarası', 'Romantik Dekor'],
      images: [
        'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
        'https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=800',
      ],
      hasPool: false,
      hasJacuzzi: true,
      hasWifi: true,
      hasParking: true,
      rating: 4.9,
      reviewCount: 15,
      ownerId: '2',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
    ),
    Bungalow(
      id: '5',
      title: 'Büyük Grup Bungalovu - Marmaris',
      description: 'Marmaris\'te arkadaş grupları için ideal, büyük bungalov. Parti alanı ve geniş mutfak ile eğlenceli tatiller.',
      location: 'Marmaris, Muğla',
      city: 'Marmaris',
      price: 4000,
      capacity: 8,
      size: 200,
      amenities: ['WiFi', 'Havuz', 'Parti Alanı', 'Geniş Mutfak', 'Parking', 'Ses Sistemi'],
      images: [
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
        'https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=800',
      ],
      hasPool: true,
      hasJacuzzi: false,
      hasWifi: true,
      hasParking: true,
      rating: 4.5,
      reviewCount: 28,
      ownerId: '2',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 75)),
    ),
    Bungalow(
      id: '6',
      title: 'Eko Dostu Bungalov - Datça',
      description: 'Datça\'da çevre dostu malzemelerle yapılmış eko bungalov. Güneş enerjisi ve doğal su kaynağı.',
      location: 'Datça, Muğla',
      city: 'Datça',
      price: 1600,
      capacity: 4,
      size: 90,
      amenities: ['WiFi', 'Güneş Enerjisi', 'Doğal Su', 'Organik Bahçe', 'Bisiklet'],
      images: [
        'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800',
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
      ],
      hasPool: false,
      hasJacuzzi: false,
      hasWifi: true,
      hasParking: true,
      rating: 4.7,
      reviewCount: 21,
      ownerId: '2',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 100)),
    ),
  ];

  // Demo yorumlar
  static final List<Review> demoReviews = [
    Review(
      id: '1',
      userId: '1',
      userName: 'Demo Kullanıcı',
      bungalowId: '1',
      rating: 5,
      comment: 'Harika bir deneyimdi! Deniz manzarası muhteşemdi ve ev çok temizdi. Kesinlikle tekrar geleceğiz.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Review(
      id: '2',
      userId: '1',
      userName: 'Demo Kullanıcı',
      bungalowId: '2',
      rating: 4,
      comment: 'Doğa içinde çok güzel bir yer. Rustik atmosfer tam istediğimiz gibiydi. WiFi biraz yavaştı ama genel olarak memnun kaldık.',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
    Review(
      id: '3',
      userId: '1',
      userName: 'Demo Kullanıcı',
      bungalowId: '3',
      rating: 5,
      comment: 'Ailemiz için mükemmeldi! Çocuklar bahçede çok eğlendi. Ev sahibi çok yardımcıydı. Teşekkürler!',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

  // Demo rezervasyonlar
  static final List<Reservation> demoReservations = [
    Reservation(
      id: '1',
      userId: '1',
      bungalowId: '1',
      checkIn: DateTime.now().add(const Duration(days: 7)),
      checkOut: DateTime.now().add(const Duration(days: 10)),
      totalPrice: 7500,
      guestCount: 2,
      status: ReservationStatus.approved,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Reservation(
      id: '2',
      userId: '1',
      bungalowId: '3',
      checkIn: DateTime.now().add(const Duration(days: 15)),
      checkOut: DateTime.now().add(const Duration(days: 18)),
      totalPrice: 3600,
      guestCount: 4,
      status: ReservationStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  // Bungalovları getir
  static List<Bungalow> getBungalows() {
    return List.from(demoBungalows);
  }

  // ID'ye göre bungalov getir
  static Bungalow? getBungalowById(String id) {
    try {
      return demoBungalows.firstWhere((bungalow) => bungalow.id == id);
    } catch (e) {
      return null;
    }
  }

  // Bungalovları filtrele
  static List<Bungalow> searchBungalows({
    String? location,
    double? minPrice,
    double? maxPrice,
    int? minGuests,
    List<String>? amenities,
  }) {
    List<Bungalow> filtered = List.from(demoBungalows);

    if (location != null && location.isNotEmpty) {
      filtered = filtered.where((bungalow) =>
          bungalow.location.toLowerCase().contains(location.toLowerCase())).toList();
    }

    if (minPrice != null) {
      filtered = filtered.where((bungalow) => bungalow.price >= minPrice).toList();
    }

    if (maxPrice != null) {
      filtered = filtered.where((bungalow) => bungalow.price <= maxPrice).toList();
    }

    if (minGuests != null) {
      filtered = filtered.where((bungalow) => bungalow.capacity >= minGuests).toList();
    }

    return filtered;
  }

  // Kullanıcıyı getir
  static User? getUserById(String id) {
    try {
      return demoUsers.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  // Demo giriş
  static Future<Map<String, dynamic>> demoLogin(String email, String password) async {
    // Demo kullanıcı kontrolü
    if (email == 'demo@bungalove.com' && password == 'demo123') {
      await Future.delayed(const Duration(seconds: 1)); // API simülasyonu
      return {
        'success': true,
        'token': 'demo_token_${DateTime.now().millisecondsSinceEpoch}',
        'expiresAt': DateTime.now().add(const Duration(hours: 24)).toIso8601String(),
        'user': demoUsers[0].toJson(),
      };
    }
    
    return {
      'success': false,
      'error': 'Geçersiz email veya şifre. Demo için: demo@bungalove.com / demo123',
    };
  }

  // Demo kayıt
  static Future<Map<String, dynamic>> demoRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    UserRole role = UserRole.user,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // API simülasyonu
    
    // Yeni kullanıcı oluştur
    final newUser = User(
      id: (demoUsers.length + 1).toString(),
      email: email,
      name: name,
      phone: phone,
      profileImage: 'https://via.placeholder.com/150',
      role: role,
      createdAt: DateTime.now(),
      isVerified: false,
    );
    
    demoUsers.add(newUser);
    
    return {
      'success': true,
      'token': 'demo_token_${DateTime.now().millisecondsSinceEpoch}',
      'expiresAt': DateTime.now().add(const Duration(hours: 24)).toIso8601String(),
      'user': newUser.toJson(),
    };
  }

  // Bungalov yorumlarını getir
  static List<Review> getReviewsForBungalow(String bungalowId) {
    return demoReviews.where((review) => review.bungalowId == bungalowId).toList();
  }

  // Kullanıcının rezervasyonlarını getir
  static List<Reservation> getUserReservations(String userId) {
    return demoReservations.where((reservation) => reservation.userId == userId).toList();
  }

  // Rezervasyon oluştur
  static Future<Map<String, dynamic>> createReservation({
    required String userId,
    required String bungalowId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int guestCount,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // API simülasyonu
    
    final bungalow = getBungalowById(bungalowId);
    if (bungalow == null) {
      return {'success': false, 'error': 'Bungalov bulunamadı'};
    }
    
    final nights = checkOut.difference(checkIn).inDays;
    final totalPrice = bungalow.price * nights;
    
    final newReservation = Reservation(
      id: (demoReservations.length + 1).toString(),
      userId: userId,
      bungalowId: bungalowId,
      checkIn: checkIn,
      checkOut: checkOut,
      totalPrice: totalPrice,
      guestCount: guestCount,
      status: ReservationStatus.pending,
      createdAt: DateTime.now(),
    );
    
    demoReservations.add(newReservation);
    
    return {
      'success': true,
      'reservation': newReservation.toJson(),
    };
  }

  // Yorum ekle
  static Future<Map<String, dynamic>> addReview({
    required String userId,
    required String bungalowId,
    required int rating,
    required String comment,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // API simülasyonu
    
    final user = getUserById(userId);
    if (user == null) {
      return {'success': false, 'error': 'Kullanıcı bulunamadı'};
    }
    
    final newReview = Review(
      id: (demoReviews.length + 1).toString(),
      userId: userId,
      userName: user.name,
      bungalowId: bungalowId,
      rating: rating.toDouble(),
      comment: comment,
      createdAt: DateTime.now(),
    );
    
    demoReviews.add(newReview);
    
    return {
      'success': true,
      'review': newReview.toJson(),
    };
  }
}