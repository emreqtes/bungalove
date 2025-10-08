# Contributing to Bungalove

Thank you for your interest in contributing to Bungalove! This document provides guidelines and information for contributors.

## 🚀 Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/yourusername/bungalove.git
   cd bungalove
   ```
3. **Add the upstream repository**:
   ```bash
   git remote add upstream https://github.com/originalowner/bungalove.git
   ```

## 📋 Development Setup

1. **Install Flutter SDK** (3.8.1 or higher)
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   ```bash
   flutter run
   ```

## 🔄 Workflow

### Creating a Pull Request

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** and commit them:
   ```bash
   git add .
   git commit -m "Add: your feature description"
   ```

3. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

4. **Create a Pull Request** on GitHub

### Branch Naming Convention

- `feature/feature-name` - New features
- `bugfix/bug-description` - Bug fixes
- `hotfix/critical-fix` - Critical fixes
- `docs/documentation-update` - Documentation updates

### Commit Message Format

Use conventional commits format:
- `Add: new feature`
- `Fix: bug description`
- `Update: existing feature`
- `Remove: deprecated feature`
- `Docs: documentation update`

## 📝 Code Style

### Dart/Flutter Guidelines

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use proper error handling

### File Structure

```
lib/
├── config/           # Configuration files
├── models/           # Data models
├── screens/          # UI screens
├── services/         # Business logic and API calls
└── main.dart         # App entry point
```

### Example Code Structure

```dart
class ExampleService {
  // Constants
  static const String _baseUrl = 'https://api.example.com';
  
  // Public methods
  static Future<Map<String, dynamic>> fetchData() async {
    try {
      // Implementation
    } catch (e) {
      // Error handling
    }
  }
  
  // Private helper methods
  static String _buildUrl(String endpoint) {
    return '$_baseUrl$endpoint';
  }
}
```

## 🧪 Testing

- Write unit tests for business logic
- Test API service methods
- Test user interactions
- Ensure all tests pass before submitting PR

```bash
# Run tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## 🐛 Reporting Issues

When reporting issues, please include:

1. **Flutter version**: `flutter --version`
2. **Device/Platform**: Android/iOS version
3. **Steps to reproduce**
4. **Expected behavior**
5. **Actual behavior**
6. **Screenshots** (if applicable)

## 💡 Feature Requests

For feature requests, please:

1. Check existing issues first
2. Describe the feature clearly
3. Explain the use case
4. Provide mockups if possible

## 📚 Documentation

- Update README.md for major changes
- Document new API endpoints
- Add inline comments for complex code
- Update this CONTRIBUTING.md if needed

## 🔍 Code Review Process

1. **Automated checks** must pass
2. **Code review** by maintainers
3. **Testing** on different devices
4. **Documentation** updates if needed

## 🎯 Areas for Contribution

- **UI/UX improvements**
- **Performance optimizations**
- **New features**
- **Bug fixes**
- **Documentation**
- **Tests**

## 📞 Getting Help

- **GitHub Issues**: For bugs and feature requests
- **Discussions**: For questions and ideas
- **Email**: support@bungalove.com

## 📄 License

By contributing to Bungalove, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Bungalove! 🏖️