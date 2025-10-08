import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../config/env_config.dart';
import 'mock_data_service.dart';
import 'storage_service.dart';

class AuthService {
  static String get _baseUrl => EnvConfig.baseUrl;
  static String get _apiVersion => EnvConfig.apiVersion;
  
  // Token storage
  static String? _authToken;
  static DateTime? _tokenExpiry;
  
  // Get current token
  static String? get authToken => _authToken;
  
  // Check if token is valid
  static bool get isTokenValid {
    if (_authToken == null || _tokenExpiry == null) return false;
    return DateTime.now().isBefore(_tokenExpiry!);
  }
  
  // Login with email and password
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Demo mode kontrolü
      if (EnvConfig.isDebugMode) {
        final demoResult = await MockDataService.demoLogin(email, password);
        if (demoResult['success'] == true) {
          // Store token
          _authToken = demoResult['token'];
          _tokenExpiry = DateTime.parse(demoResult['expiresAt']);

          // Save to storage
          await StorageService.saveToken(demoResult['token'], _tokenExpiry!);

          return {
            'success': true,
            'user': User.fromJson(demoResult['user']),
            'token': _authToken,
          };
        } else {
          return demoResult;
        }
      }

      // Gerçek API çağrısı
      final response = await http.post(
        Uri.parse('$_baseUrl$_apiVersion/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Store token
        _authToken = data['token'];
        _tokenExpiry = DateTime.parse(data['expiresAt']);
        
        // Create user object
        final user = User.fromJson(data['user']);
        
        return {
          'success': true,
          'user': user,
          'token': _authToken,
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Giriş başarısız',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Bağlantı hatası: $e',
      };
    }
  }
  
  // Register new user
  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$_apiVersion/auth/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
          'role': role,
        }),
      );
      
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        
        // Store token
        _authToken = data['token'];
        _tokenExpiry = DateTime.parse(data['expiresAt']);
        
        // Create user object
        final user = User.fromJson(data['user']);
        
        return {
          'success': true,
          'user': user,
          'token': _authToken,
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Kayıt başarısız',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Bağlantı hatası: $e',
      };
    }
  }
  
  // Logout
  static Future<bool> logout() async {
    try {
      if (_authToken != null) {
        await http.post(
          Uri.parse('$_baseUrl$_apiVersion/auth/logout'),
          headers: {
            'Authorization': 'Bearer $_authToken',
            'Content-Type': 'application/json',
          },
        );
      }
      
      // Clear local token
      _authToken = null;
      _tokenExpiry = null;
      
      return true;
    } catch (e) {
      // Even if logout fails, clear local token
      _authToken = null;
      _tokenExpiry = null;
      return false;
    }
  }
  
  // Refresh token
  static Future<bool> refreshToken() async {
    try {
      if (_authToken == null) return false;
      
      final response = await http.post(
        Uri.parse('$_baseUrl$_apiVersion/auth/refresh'),
        headers: {
          'Authorization': 'Bearer $_authToken',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _authToken = data['token'];
        _tokenExpiry = DateTime.parse(data['expiresAt']);
        return true;
      }
      
      return false;
    } catch (e) {
      return false;
    }
  }
  
  // Validate current token
  static Future<bool> validateToken() async {
    try {
      if (_authToken == null) return false;
      
      final response = await http.get(
        Uri.parse('$_baseUrl$_apiVersion/auth/validate'),
        headers: {
          'Authorization': 'Bearer $_authToken',
        },
      );
      
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
  
  // Get current user from server
  static Future<User?> getCurrentUser() async {
    try {
      if (_authToken == null) return null;
      
      final response = await http.get(
        Uri.parse('$_baseUrl$_apiVersion/auth/me'),
        headers: {
          'Authorization': 'Bearer $_authToken',
        },
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }
  
  // Update user profile
  static Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? phone,
    String? profileImage,
  }) async {
    try {
      if (_authToken == null) {
        return {
          'success': false,
          'error': 'Token bulunamadı',
        };
      }
      
      final response = await http.put(
        Uri.parse('$_baseUrl$_apiVersion/auth/profile'),
        headers: {
          'Authorization': 'Bearer $_authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          if (name != null) 'name': name,
          if (phone != null) 'phone': phone,
          if (profileImage != null) 'profileImage': profileImage,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data);
        
        return {
          'success': true,
          'user': user,
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Güncelleme başarısız',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Bağlantı hatası: $e',
      };
    }
  }
  
  // Change password
  static Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      if (_authToken == null) {
        return {
          'success': false,
          'error': 'Token bulunamadı',
        };
      }
      
      final response = await http.put(
        Uri.parse('$_baseUrl$_apiVersion/auth/password'),
        headers: {
          'Authorization': 'Bearer $_authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Şifre değiştirme başarısız',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Bağlantı hatası: $e',
      };
    }
  }
  
  // Forgot password
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$_apiVersion/auth/forgot-password'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
        }),
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Şifre sıfırlama bağlantısı e-posta adresinize gönderildi',
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Şifre sıfırlama başarısız',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Bağlantı hatası: $e',
      };
    }
  }
  
  // Reset password
  static Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$_apiVersion/auth/reset-password'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'token': token,
          'newPassword': newPassword,
        }),
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Şifreniz başarıyla değiştirildi',
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Şifre sıfırlama başarısız',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Bağlantı hatası: $e',
      };
    }
  }
} 