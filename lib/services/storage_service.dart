import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class StorageService {
  static const String _tokenKey = 'auth_token';
  static const String _tokenExpiryKey = 'auth_token_expiry';
  static const String _userKey = 'current_user';
  
  // Save token
  static Future<void> saveToken(String token, DateTime expiry) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_tokenExpiryKey, expiry.toIso8601String());
  }
  
  // Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
  
  // Get token expiry
  static Future<DateTime?> getTokenExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryString = prefs.getString(_tokenExpiryKey);
    if (expiryString != null) {
      return DateTime.parse(expiryString);
    }
    return null;
  }
  
  // Save user
  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }
  
  // Get user
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);
    if (userString != null) {
      try {
        final userJson = jsonDecode(userString);
        return User.fromJson(userJson);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
  
  // Clear all auth data
  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_tokenExpiryKey);
    await prefs.remove(_userKey);
  }
  
  // Check if user is logged in (local check)
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    final expiry = await getTokenExpiry();
    
    if (token == null || expiry == null) return false;
    
    return DateTime.now().isBefore(expiry);
  }
  
  // Initialize auth state from storage
  static Future<Map<String, dynamic>> initializeAuthState() async {
    final token = await getToken();
    final expiry = await getTokenExpiry();
    final user = await getUser();
    
    if (token != null && expiry != null && user != null) {
      final isValid = DateTime.now().isBefore(expiry);
      
      return {
        'isLoggedIn': isValid,
        'user': isValid ? user : null,
        'token': isValid ? token : null,
      };
    }
    
    return {
      'isLoggedIn': false,
      'user': null,
      'token': null,
    };
  }
} 