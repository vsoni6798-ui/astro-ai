import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/ai_service.dart';
import '../services/user_provider.dart';
import '../widgets/star_background.dart';
import '../theme/app_theme.dart';

class _ChatMessage {
  final String text;
  final bool isUser;
  _ChatMessage(this.text, this.isUser);
}

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _messages.add(_ChatMessage(
      'Hi! I\'m your AI Astrology Guide ✨ Ask me anything about your love life, career, or what the stars have planned for you.',
      false,
    ));
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _loading) return;

    final sign = context.read<UserProvider>().zodiacSign.name;
    setState(() {
      _messages.add(_ChatMessage(text, true));
      _loading = true;
      _controller.clear();
    });
    _scrollToBottom();

    final reply = await AiService.ask(zodiacSign: sign, question: text);

    if (!mounted) return;
    setState(() {
      _messages.add(_ChatMessage(reply, false));
      _loading = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StarBackground(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    Text('🤖', style: TextStyle(fontSize: 24)),
                    SizedBox(width: 10),
                    Text('AI Astrology Guide',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length + (_loading ? 1 : 0),
                  itemBuilder: (context, i) {
                    if (i == _messages.length) {
                      return _bubble('Reading the stars...', false, loading: true);
                    }
                    final m = _messages[i];
                    return _bubble(m.text, m.isUser);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        onSubmitted: (_) => _send(),
                        decoration: const InputDecoration(
                          hintText: 'Ask about love, career, health...',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: _send,
                      icon: const Icon(Icons.send),
                      style: IconButton.styleFrom(backgroundColor: AppTheme.mysticPurple),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bubble(String text, bool isUser, {bool loading = false}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? AppTheme.mysticPurple : AppTheme.midnight,
          borderRadius: BorderRadius.circular(18),
        ),
        child: loading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.starGold),
              )
            : Text(text, style: TextStyle(color: Colors.white.withOpacity(0.95), height: 1.4)),
      ),
    );
  }
}
