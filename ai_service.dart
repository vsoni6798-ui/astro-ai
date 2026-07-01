import 'dart:convert';
import 'package:http/http.dart' as http;

/// AI Astrology Assistant service.
///
/// ⚠️ IMPORTANT — READ BEFORE SHIPPING:
/// Never call an LLM API (OpenAI, Anthropic, etc.) directly from the mobile
/// client with an embedded API key — it will be extracted from the compiled
/// app binary and abused. Instead:
///
///   1. Stand up a tiny backend (Cloud Function, Vercel/Node endpoint, or
///      similar) that holds your API key server-side.
///   2. Point `_backendUrl` below at that endpoint.
///   3. Your backend receives {sign, question}, calls the LLM API
///      (e.g. Anthropic's /v1/messages with a system prompt describing an
///      astrology assistant persona), and returns {reply: "..."}.
///
/// Until that backend exists, this service falls back to canned responses
/// so the app remains fully demoable offline.
class AiService {
  static const String _backendUrl = 'https://YOUR_BACKEND_URL/api/astrology-chat';
  static const bool useBackend = false; // flip to true once _backendUrl is live

  static Future<String> ask({
    required String zodiacSign,
    required String question,
  }) async {
    if (useBackend) {
      try {
        final response = await http.post(
          Uri.parse(_backendUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'sign': zodiacSign, 'question': question}),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['reply'] as String? ?? _fallback(zodiacSign, question);
        }
      } catch (_) {
        // fall through to local fallback on any network error
      }
    }
    return _fallback(zodiacSign, question);
  }

  /// Local, deterministic-ish fallback so the chat screen is usable without
  /// a backend during development and demos.
  static String _fallback(String sign, String question) {
    final q = question.toLowerCase();

    if (q.contains('love') || q.contains('relationship')) {
      return 'As a $sign, your relationships thrive when you lead with honesty rather than assumption. '
          'Right now, the clearest path forward is a direct conversation, not a guessing game.';
    }
    if (q.contains('career') || q.contains('job') || q.contains('work')) {
      return 'For $sign, this is a season for steady, visible effort. Avoid overcommitting — '
          'one well-finished project will do more for you than three half-finished ones.';
    }
    if (q.contains('money') || q.contains('finance')) {
      return '$sign energy this month favors patience over impulse with money. '
          'Delay non-essential purchases by 48 hours and you will make better calls.';
    }
    if (q.contains('health')) {
      return 'Your $sign chart suggests your body is asking for consistency, not intensity — '
          'a small daily habit will outperform an occasional big effort.';
    }
    return 'As a $sign, trust the instinct that keeps returning to you about this. '
          'The stars point to clarity, but the decision — as always — is yours to make.';
  }
}
