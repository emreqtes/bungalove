import 'package:flutter/material.dart';
import '../models/bungalow.dart';
import '../services/data_service.dart';
import 'listing_detail_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class ListingScreen extends StatelessWidget {
  ListingScreen({Key? key}) : super(key: key);

  final DataService _dataService = DataService();

  @override
  Widget build(BuildContext context) {
    final List<Bungalow> listings = _dataService.getSampleBungalows();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bungalovlar'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(allListings: listings),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: listings.length,
        itemBuilder: (context, index) {
          final bungalow = listings[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.network(
                bungalow.images.first, 
                width: 60, 
                height: 60, 
                fit: BoxFit.cover
              ),
              title: Text(bungalow.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${bungalow.location} - ₺${bungalow.price.toStringAsFixed(0)}/gece'),
                  Row(
                    children: [
                      const Icon(Icons.square_foot, size: 18, color: Colors.green),
                      Text(' ${bungalow.size} m²  '),
                      const Icon(Icons.people, size: 18, color: Colors.green),
                      Text(' ${bungalow.capacity} kişi  '),
                      Icon(
                        Icons.hot_tub, 
                        color: bungalow.hasJacuzzi ? Colors.green : Colors.grey, 
                        size: 20
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.pool, 
                        color: bungalow.hasPool ? Colors.green : Colors.grey, 
                        size: 20
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListingDetailScreen(bungalow: bungalow),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
} 