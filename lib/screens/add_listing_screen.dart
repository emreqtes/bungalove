import 'package:flutter/material.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _cityController = TextEditingController();
  final _priceController = TextEditingController();
  final _capacityController = TextEditingController();
  final _sizeController = TextEditingController();

  bool _hasPool = false;
  bool _hasJacuzzi = false;
  bool _hasWifi = true;
  bool _hasParking = true;
  List<String> _selectedAmenities = [];
  List<String> _imageUrls = [];
  bool _isLoading = false;

  final List<String> _amenityOptions = [
    'Kitchen',
    'Balcony',
    'Lake View',
    'Mountain View',
    'Sea View',
    'BBQ',
    'Fireplace',
    'Ski Storage',
    'River Access',
    'Hiking Trails',
    'Private Beach',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _cityController.dispose();
    _priceController.dispose();
    _capacityController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bungalov Ekle'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information
              _buildSectionTitle('Temel Bilgiler'),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Bungalov Adı *',
                  hintText: 'Örn: Sapanca Göl Kenarı Bungalov',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bungalov adı gereklidir';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Açıklama *',
                  hintText: 'Bungalovunuzun özelliklerini ve çevresini anlatın...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Açıklama gereklidir';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Konum *',
                        hintText: 'Örn: Sapanca, Sakarya',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konum gereklidir';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        labelText: 'Şehir *',
                        hintText: 'Örn: Sapanca',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Şehir gereklidir';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Pricing and Capacity
              _buildSectionTitle('Fiyat ve Kapasite'),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Gecelik Fiyat (₺) *',
                        hintText: '1200',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Fiyat gereklidir';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Geçerli bir fiyat giriniz';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _capacityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Kapasite (Kişi) *',
                        hintText: '4',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kapasite gereklidir';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Geçerli bir sayı giriniz';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _sizeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Büyüklük (m²) *',
                  hintText: '80',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Büyüklük gereklidir';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Geçerli bir sayı giriniz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Amenities
              _buildSectionTitle('Özellikler'),
              const SizedBox(height: 16),

              // Basic amenities
              const Text(
                'Temel Özellikler',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('WiFi'),
                      value: _hasWifi,
                      onChanged: (value) {
                        setState(() {
                          _hasWifi = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Parking'),
                      value: _hasParking,
                      onChanged: (value) {
                        setState(() {
                          _hasParking = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Havuz'),
                      value: _hasPool,
                      onChanged: (value) {
                        setState(() {
                          _hasPool = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Jakuzi'),
                      value: _hasJacuzzi,
                      onChanged: (value) {
                        setState(() {
                          _hasJacuzzi = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Additional amenities
              const Text(
                'Ek Özellikler',
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
                    },
                    selectedColor: Colors.green[100],
                    checkmarkColor: Colors.green[700],
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Images
              _buildSectionTitle('Fotoğraflar'),
              const SizedBox(height: 16),

              // Placeholder for image upload
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate, size: 32, color: Colors.grey[400]),
                      const SizedBox(height: 8),
                      Text(
                        'Fotoğraf ekle',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Fotoğraf ekleme özelliği MVP sonrası eklenecektir',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Bungalovu Yayınla',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }

  String _getAmenityLabel(String amenity) {
    switch (amenity) {
      case 'Kitchen':
        return 'Mutfak';
      case 'Balcony':
        return 'Balkon';
      case 'Lake View':
        return 'Göl Manzarası';
      case 'Mountain View':
        return 'Dağ Manzarası';
      case 'Sea View':
        return 'Deniz Manzarası';
      case 'BBQ':
        return 'Mangal';
      case 'Fireplace':
        return 'Şömine';
      case 'Ski Storage':
        return 'Kayak Deposu';
      case 'River Access':
        return 'Nehir Erişimi';
      case 'Hiking Trails':
        return 'Yürüyüş Yolları';
      case 'Private Beach':
        return 'Özel Plaj';
      default:
        return amenity;
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Show success dialog
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Başarılı!'),
          content: const Text(
            'Bungalovunuz başarıyla eklendi ve yayınlandı. '
            'Rezervasyon talepleri artık kabul edilmeye başlanacak.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }
} 