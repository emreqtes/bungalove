import 'user.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class CurrentUser {
  static User? _currentUser;
  static bool _isLoggedIn = false;
  static bool _isInitialized = false;

  // Giriş durumunu kontrol et
  static bool get isLoggedIn => _isLoggedIn;
  
  // Mevcut kullanıcıyı al
  static User? get currentUser => _currentUser;
  
  // Initialize auth state
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    final authState = await StorageService.initializeAuthState();
    _isLoggedIn = authState['isLoggedIn'];
    _currentUser = authState['user'];
    
    // Set token in AuthService
    if (authState['token'] != null) {
      // Note: AuthService token management will be handled separately
    }
    
    _isInitialized = true;
  }

  // Kullanıcı giriş yaptığında
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final result = await AuthService.login(email, password);
    
    if (result['success']) {
      _currentUser = result['user'];
      _isLoggedIn = true;
      
      // Save to storage
      await StorageService.saveToken(result['token'], DateTime.now().add(Duration(hours: 24)));
      await StorageService.saveUser(_currentUser!);
    }
    
    return result;
  }
  
  // Kullanıcı çıkış yaptığında
  static Future<void> logout() async {
    await AuthService.logout();
    await StorageService.clearAuthData();
    
    _currentUser = null;
    _isLoggedIn = false;
  }
  
  // Kullanıcı bilgilerini güncelle
  static Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? phone,
    String? profileImage,
  }) async {
    final result = await AuthService.updateProfile(
      name: name,
      phone: phone,
      profileImage: profileImage,
    );
    
    if (result['success']) {
      _currentUser = result['user'];
      await StorageService.saveUser(_currentUser!);
    }
    
    return result;
  }
  
  // Token'ı yenile
  static Future<bool> refreshToken() async {
    final success = await AuthService.refreshToken();
    if (success) {
      // Update stored token
      final token = AuthService.authToken;
      if (token != null) {
        await StorageService.saveToken(token, DateTime.now().add(Duration(hours: 24)));
      }
    }
    return success;
  }
  
  // Token'ı doğrula
  static Future<bool> validateToken() async {
    return await AuthService.validateToken();
  }
  
  // Şifre değiştir
  static Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await AuthService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
  
  // Şifremi unuttum
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    return await AuthService.forgotPassword(email);
  }
  
  // Şifre sıfırla
  static Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    return await AuthService.resetPassword(
      token: token,
      newPassword: newPassword,
    );
  }
  
  // Auto login from storage
  static Future<bool> autoLogin() async {
    final isLoggedIn = await StorageService.isLoggedIn();
    if (isLoggedIn) {
      final user = await StorageService.getUser();
      if (user != null) {
        _currentUser = user;
        _isLoggedIn = true;
        return true;
      }
    }
    return false;
  }
} 