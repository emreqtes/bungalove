import 'package:flutter/material.dart';
import '../models/bungalow.dart';
import '../services/data_service.dart';
import 'listing_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final List<Bungalow> allListings;

  const SearchScreen({super.key, required this.allListings});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final DataService _dataService = DataService();
  final TextEditingController _searchController = TextEditingController();
  
  List<Bungalow> _filteredListings = [];
  String _searchQuery = '';
  double _minPrice = 0;
  double _maxPrice = 5000;
  int _selectedCapacity = 1;
  List<String> _selectedAmenities = [];
  bool _showFilters = false;

  final List<String> _amenityOptions = ['pool', 'jacuzzi', 'wifi', 'parking'];

  @override
  void initState() {
    super.initState();
    _filteredListings = widget.allListings;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      _filteredListings = widget.allListings;

      // Apply search query
      if (_searchQuery.isNotEmpty) {
        _filteredListings = _dataService.searchBungalows(_searchQuery);
      }

      // Apply price filter
      _filteredListings = _dataService.filterByPriceRange(
        _filteredListings,
        _minPrice,
        _maxPrice,
      );

      // Apply capacity filter
      _filteredListings = _dataService.filterByCapacity(
        _filteredListings,
        _selectedCapacity,
      );

      // Apply amenities filter
      if (_selectedAmenities.isNotEmpty) {
        _filteredListings = _dataService.filterByAmenities(
          _filteredListings,
          _selectedAmenities,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bungalov Ara'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_showFilters ? Icons.filter_list : Icons.filter_list_outlined),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Bölge, şehir veya bungalov adı ara...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                          _applyFilters();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _applyFilters();
              },
            ),
          ),

          // Filters
          if (_showFilters)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filtreler',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price Range
                  const Text(
                    'Fiyat Aralığı',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RangeSlider(
                    values: RangeValues(_minPrice, _maxPrice),
                    min: 0,
                    max: 5000,
                    divisions: 50,
                    labels: RangeLabels(
                      '₺${_minPrice.toInt()}',
                      '₺${_maxPrice.toInt()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _minPrice = values.start;
                        _maxPrice = values.end;
                      });
                      _applyFilters();
                    },
                  ),

                  const SizedBox(height: 16),

                  // Capacity
                  const Text(
                    'Kişi Sayısı',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    value: _selectedCapacity,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: List.generate(10, (index) => index + 1)
                        .map((capacity) => DropdownMenuItem(
                              value: capacity,
                              child: Text('$capacity kişi'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCapacity = value!;
                      });
                      _applyFilters();
                    },
                  ),

                  const SizedBox(height: 16),

                  // Amenities
                  const Text(
                    'Özellikler',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _amenityOptions.map((amenity) {
                      final isSelected = _selectedAmenities.contains(amenity);
                      return FilterChip(
                        label: Text(_getAmenityLabel(amenity)),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedAmenities.add(amenity);
                            } else {
                              _selectedAmenities.remove(amenity);
                            }
                          });
                          _applyFilters();
                        },
                        selectedColor: Colors.green[100],
                        checkmarkColor: Colors.green[700],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredListings.length} sonuç bulundu',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                if (_searchQuery.isNotEmpty || _minPrice > 0 || _maxPrice < 5000 || _selectedCapacity > 1 || _selectedAmenities.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                        _minPrice = 0;
                        _maxPrice = 5000;
                        _selectedCapacity = 1;
                        _selectedAmenities.clear();
                      });
                      _applyFilters();
                    },
                    child: const Text('Filtreleri Temizle'),
                  ),
              ],
            ),
          ),

          // Results List
          Expanded(
            child: _filteredListings.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'Sonuç bulunamadı',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Farklı arama kriterleri deneyin',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _filteredListings.length,
                    itemBuilder: (context, index) {
                      final bungalow = _filteredListings[index];
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
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 8,
                                      children: [
                                        if (bungalow.hasWifi)
                                          _buildAmenityChip(Icons.wifi, 'WiFi'),
                                        if (bungalow.hasParking)
                                          _buildAmenityChip(Icons.local_parking, 'Parking'),
                                        if (bungalow.hasPool)
                                          _buildAmenityChip(Icons.pool, 'Havuz'),
                                        if (bungalow.hasJacuzzi)
                                          _buildAmenityChip(Icons.hot_tub, 'Jakuzi'),
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
          ),
        ],
      ),
    );
  }

  String _getAmenityLabel(String amenity) {
    switch (amenity) {
      case 'pool':
        return 'Havuz';
      case 'jacuzzi':
        return 'Jakuzi';
      case 'wifi':
        return 'WiFi';
      case 'parking':
        return 'Parking';
      default:
        return amenity;
    }
  }

  Widget _buildAmenityChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.green[700]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.green[700],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 