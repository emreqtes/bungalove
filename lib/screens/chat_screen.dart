import 'package:flutter/material.dart';
import '../models/current_user.dart';
import 'login_screen.dart';

class ChatScreen extends StatefulWidget {
  final String listingTitle;
  final String ownerName;
  const ChatScreen({Key? key, required this.listingTitle, required this.ownerName}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> messages = [
    {'sender': 'Kullanıcı', 'text': 'Merhaba, bungalovunuz müsait mi?'},
    {'sender': 'İlan Verici', 'text': 'Merhaba, evet müsait. Hangi tarihler için düşünüyorsunuz?'},
  ];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    
    // Giriş kontrolü
    if (!CurrentUser.isLoggedIn) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Giriş Gerekli'),
          content: const Text('Mesaj göndermek için lütfen giriş yapın.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const LoginScreen(isModal: true),
                );
              },
              child: const Text('Giriş Yap'),
            ),
          ],
        ),
      );
      return;
    }
    
    setState(() {
      messages.add({'sender': 'Kullanıcı', 'text': _controller.text.trim()});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.ownerName} ile Sohbet', style: const TextStyle(fontSize: 18)),
            Text(widget.listingTitle, style: const TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg['sender'] == 'Kullanıcı';
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.green[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg['text'] ?? ''),
                  ),
                );
              },
            ),
          ),
          if (!CurrentUser.isLoggedIn)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Mesaj göndermek için giriş yapmanız gerekiyor.',
                      style: TextStyle(color: Colors.orange[700]),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: CurrentUser.isLoggedIn 
                          ? 'Mesajınızı yazın...' 
                          : 'Giriş yapın...',
                      enabled: CurrentUser.isLoggedIn,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send, 
                    color: CurrentUser.isLoggedIn ? Colors.green : Colors.grey,
                  ),
                  onPressed: CurrentUser.isLoggedIn ? _sendMessage : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 