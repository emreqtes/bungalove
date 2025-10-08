class EnvConfig {
  // Development environment
  static const String devBaseUrl = 'http://localhost:3000';
  
  // Production environment
  static const String prodBaseUrl = 'https://api.bungalove.com';
  
  // API version
  static const String apiVersion = '/api/v1';
  
  // Get base URL based on environment
  static String get baseUrl {
    // You can change this to determine environment
    // For now, using production URL
    return prodBaseUrl;
  }
  
  // Get full API URL
  static String get apiUrl => baseUrl + apiVersion;
  
  // Environment specific settings
  static const bool isDebugMode = true;
  static const bool enableLogging = true;
  
  // API timeout settings
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
}