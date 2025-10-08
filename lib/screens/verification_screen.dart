import 'package:flutter/material.dart';
import 'listing_screen.dart';
import '../models/current_user.dart';
import '../models/user.dart';

class VerificationScreen extends StatefulWidget {
  final String phone;
  final String email;
  final String role;
  const VerificationScreen({super.key, required this.phone, required this.email, required this.role});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _codeController = TextEditingController();
  final String _dummyCode = '1234';
  bool _error = false;

  void _verify() {
    if (_codeController.text == _dummyCode) {
      // Create a new user with the provided information
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: widget.email,
        name: widget.email.split('@')[0], // Use email prefix as name for now
        phone: widget.phone,
        role: widget.role == 'owner' ? UserRole.owner : UserRole.user,
        createdAt: DateTime.now(),
        isVerified: true,
      );
      
      CurrentUser.login(user.email, 'password'); // For MVP, using default password
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ListingScreen()),
        (route) => false,
      );
    } else {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Telefon Doğrulama')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.phone} numarasına doğrulama kodu gönderildi.',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Doğrulama Kodu',
                errorText: _error ? 'Kod yanlış!' : null,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _verify,
              child: const Text('Doğrula'),
            ),
            const SizedBox(height: 12),
            const Text('Örnek kod: 1234', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
} 