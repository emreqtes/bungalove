import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/current_user.dart';
import '../services/data_service.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DataService _dataService = DataService();
  late User _user;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _user = CurrentUser.currentUser ?? _dataService.getSampleUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilim'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
              if (!_isEditing) {
                // Save changes
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Değişiklikler kaydedildi')),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.green[100],
                      child: _user.profileImage != null
                          ? ClipOval(
                              child: Image.network(
                                _user.profileImage!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.green[700],
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _user.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _user.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green[200]!),
                      ),
                      child: Text(
                        _getRoleLabel(_user.role),
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Profile Information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kişisel Bilgiler',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Ad Soyad', _user.name, Icons.person),
                    const SizedBox(height: 12),
                    _buildInfoRow('E-posta', _user.email, Icons.email),
                    const SizedBox(height: 12),
                    _buildInfoRow('Telefon', _user.phone ?? 'Belirtilmemiş', Icons.phone),
                    const SizedBox(height: 12),
                    _buildInfoRow('Üyelik Tarihi', _formatDate(_user.createdAt), Icons.calendar_today),
                    const SizedBox(height: 12),
                    _buildInfoRow('Doğrulama Durumu', _user.isVerified ? 'Doğrulanmış' : 'Doğrulanmamış', Icons.verified),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hızlı İşlemler',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildActionTile(
                      icon: Icons.home_work,
                      title: 'Bungalovlarım',
                      subtitle: 'Eklediğim bungalovları görüntüle',
                      onTap: () {
                        // Navigate to my bungalows
                      },
                    ),
                    _buildActionTile(
                      icon: Icons.bookmark,
                      title: 'Rezervasyonlarım',
                      subtitle: 'Rezervasyon geçmişimi görüntüle',
                      onTap: () {
                        // Navigate to my reservations
                      },
                    ),
                    _buildActionTile(
                      icon: Icons.favorite,
                      title: 'Favorilerim',
                      subtitle: 'Favori bungalovlarım',
                      onTap: () {
                        // Navigate to favorites
                      },
                    ),
                    _buildActionTile(
                      icon: Icons.message,
                      title: 'Mesajlarım',
                      subtitle: 'Gelen ve giden mesajlar',
                      onTap: () {
                        // Navigate to messages
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Settings
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ayarlar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildActionTile(
                      icon: Icons.notifications,
                      title: 'Bildirimler',
                      subtitle: 'Bildirim ayarlarını yönet',
                      onTap: () {
                        // Navigate to notification settings
                      },
                    ),
                    _buildActionTile(
                      icon: Icons.security,
                      title: 'Güvenlik',
                      subtitle: 'Şifre ve güvenlik ayarları',
                      onTap: () {
                        // Navigate to security settings
                      },
                    ),
                    _buildActionTile(
                      icon: Icons.help,
                      title: 'Yardım',
                      subtitle: 'Sık sorulan sorular ve destek',
                      onTap: () {
                        // Navigate to help
                      },
                    ),
                    _buildActionTile(
                      icon: Icons.info,
                      title: 'Hakkında',
                      subtitle: 'Uygulama bilgileri',
                      onTap: () {
                        // Show about dialog
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _handleLogout,
                icon: const Icon(Icons.logout),
                label: const Text('Çıkış Yap'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.green[700], size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  String _getRoleLabel(UserRole role) {
    switch (role) {
      case UserRole.user:
        return 'Kullanıcı';
      case UserRole.owner:
        return 'Bungalov Sahibi';
      case UserRole.admin:
        return 'Yönetici';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text('Hesabınızdan çıkmak istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              CurrentUser.logout();
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: const Text(
              'Çıkış Yap',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
} 