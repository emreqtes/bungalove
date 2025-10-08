import 'package:flutter/material.dart';
import '../models/bungalow.dart';
import '../models/current_user.dart';
import '../services/data_service.dart';

import 'search_screen.dart';
import 'add_listing_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import 'listing_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataService _dataService = DataService();
  
  @override
  void initState() {
    super.initState();
    // Uygulama açıldığında giriş ekranını modal olarak göster
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Auto login kontrolü
      final autoLoginSuccess = await CurrentUser.autoLogin();
      
      if (!autoLoginSuccess && !CurrentUser.isLoggedIn) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const LoginScreen(isModal: true),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Bungalow> featuredBungalows = _dataService.getSampleBungalows().take(3).toList();
    final List<String> popularLocations = _dataService.getPopularLocations();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Bungalove',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        actions: [
          if (CurrentUser.isLoggedIn)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 8.0),
              child: PopupMenuButton<String>(
                icon: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.green, size: 28),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onSelected: (value) {
                  if (value == 'Profilim') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                  } else if (value == 'İlanlarım') {
                    // İlanlarım ekranı eklenecek
                  } else if (value == 'Rezervasyonlarım') {
                    // Rezervasyonlarım ekranı eklenecek
                  } else if (value == 'Çıkış Yap') {
                    CurrentUser.logout();
                    setState(() {});
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'Profilim', child: ListTile(leading: Icon(Icons.person), title: Text('Profilim'))),
                  const PopupMenuItem(value: 'İlanlarım', child: ListTile(leading: Icon(Icons.home_work), title: Text('İlanlarım'))),
                  const PopupMenuItem(value: 'Rezervasyonlarım', child: ListTile(leading: Icon(Icons.bookmark), title: Text('Rezervasyonlarım'))),
                  const PopupMenuDivider(),
                  const PopupMenuItem(value: 'Çıkış Yap', child: ListTile(leading: Icon(Icons.logout), title: Text('Çıkış Yap'))),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const LoginScreen(isModal: true),
                  );
                },
                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Hayalinizdeki Tatili Keşfedin',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 8,
                                color: Colors.black54,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Doğayla iç içe, huzurlu bungalov deneyimi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black54,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(allListings: featuredBungalows),
                              ),
                            );
                          },
                          child: const Text('Bungalovları Keşfet'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Popular Locations
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Popüler Bölgeler',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularLocations.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(
                                    allListings: _dataService.searchBungalows(popularLocations[index]),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[50],
                              foregroundColor: Colors.green[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(popularLocations[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Featured Bungalows
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Öne Çıkan Bungalovlar',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: featuredBungalows.length,
                    itemBuilder: (context, index) {
                      final bungalow = featuredBungalows[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListingDetailScreen(bungalow: bungalow),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                child: Image.network(
                                  bungalow.images.first,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            bungalow.title,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '₺${bungalow.price.toStringAsFixed(0)}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                                        const SizedBox(width: 4),
                                        Text(
                                          bungalow.location,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.star, size: 16, color: Colors.amber),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${bungalow.rating} (${bungalow.reviewCount} değerlendirme)',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${bungalow.capacity} kişi',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CurrentUser.isLoggedIn
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddListingScreen()),
                );
              },
              child: const Icon(Icons.add, size: 32),
              backgroundColor: Colors.green[700],
              elevation: 6,
            )
          : null,
    );
  }
} 