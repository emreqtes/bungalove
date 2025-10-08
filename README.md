# Bungalove 🏖️

A Flutter-based mobile application for booking and renting bungalows and vacation rentals.

## 📱 Features

- **User Authentication**: Secure login and registration system
- **Property Listings**: Browse and search available bungalows
- **Reservation System**: Book and manage reservations
- **User Profiles**: Manage personal information and preferences
- **Reviews & Ratings**: Rate and review properties
- **Real-time Chat**: Communicate with property owners
- **Search & Filters**: Find properties based on location, dates, and preferences

## 🛠️ Tech Stack

- **Framework**: Flutter 3.8.1+
- **Language**: Dart
- **HTTP Client**: http package for API calls
- **Local Storage**: shared_preferences for token management
- **Architecture**: Service-based architecture with separate models and screens

## 📋 Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Git

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/bungalove.git
cd bungalove
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Configure environment
Update the API configuration in `lib/config/env_config.dart`:
```dart
// For development
static const String devBaseUrl = 'http://your-dev-api.com';

// For production
static const String prodBaseUrl = 'https://api.bungalove.com';
```

### 4. Demo Mode
The app includes a demo mode with sample data:
- **Demo Login**: `demo@bungalove.com` / `demo123`
- **Sample Properties**: 6 different bungalows with realistic data
- **Mock Reviews**: User reviews and ratings
- **Demo Reservations**: Sample booking data

### 5. Run the app
```bash
# For debug mode
flutter run

# For release mode
flutter run --release
```

## 📁 Project Structure

```
lib/
├── config/           # Configuration files
├── models/           # Data models
├── screens/          # UI screens
├── services/         # Business logic and API calls
└── main.dart         # App entry point
```

## 🔧 Configuration

### API Configuration
The app uses environment-based configuration. Update `lib/config/env_config.dart` to set:
- Base API URL
- API version
- Timeout settings
- Debug mode settings

### Backend API
See [BACKEND_API.md](BACKEND_API.md) for planned API documentation and development roadmap.

**Note**: Currently using mock data. Backend API is in planning phase.

## 📱 Screenshots

*Add screenshots of your app here*

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, email support@bungalove.com or create an issue in this repository.

## 🗺️ Roadmap

- [ ] Push notifications
- [ ] Offline mode support
- [ ] Advanced search filters
- [ ] Payment integration
- [ ] Multi-language support
- [ ] Dark mode theme

---

Made with ❤️ using Flutter
