import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/zodiac_data.dart';
import '../data/horoscope_generator.dart';
import '../models/horoscope.dart';
import '../services/user_provider.dart';
import '../widgets/star_background.dart';
import '../theme/app_theme.dart';

class CompatibilityScreen extends StatefulWidget {
  const CompatibilityScreen({super.key});

  @override
  State<CompatibilityScreen> createState() => _CompatibilityScreenState();
}

class _CompatibilityScreenState extends State<CompatibilityScreen> {
  String? _partnerSign;
  CompatibilityResult? _result;

  @override
  Widget build(BuildContext context) {
    final userSign = context.watch<UserProvider>().zodiacSign;

    return Scaffold(
      body: StarBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text('Compatibility Check',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('See how ${userSign.name} matches with another sign.',
                  style: const TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _signBadge(userSign.symbol, userSign.name, userSign.primaryColor)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(Icons.favorite, color: AppTheme.starGold),
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _partnerSign,
                      dropdownColor: AppTheme.midnight,
                      decoration: const InputDecoration(labelText: 'Partner sign'),
                      items: ZodiacData.signs
                          .map((s) => DropdownMenuItem(
                                value: s.name,
                                child: Text('${s.symbol} ${s.name}'),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _partnerSign = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _partnerSign == null
                      ? null
                      : () => setState(() {
                            _result = HoroscopeGenerator.compatibility(
                                userSign.name, _partnerSign!);
                          }),
                  child: const Text('Check Compatibility'),
                ),
              ),
              if (_result != null) ...[
                const SizedBox(height: 28),
                _ResultCard(result: _result!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _signBadge(String symbol, String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(symbol, style: TextStyle(fontSize: 26, color: color)),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final CompatibilityResult result;
  const _ResultCard({required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.midnight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text('${result.score}%',
              style: const TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold, color: AppTheme.starGold)),
          Text('${result.signA} + ${result.signB}',
              style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: result.score / 100,
              minHeight: 10,
              backgroundColor: Colors.white12,
              color: AppTheme.starGold,
            ),
          ),
          const SizedBox(height: 20),
          _detailRow('💫', result.summary),
          const SizedBox(height: 10),
          _detailRow('💖', result.loveNote),
          const SizedBox(height: 10),
          _detailRow('🤝', result.friendshipNote),
        ],
      ),
    );
  }

  Widget _detailRow(String emoji, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(color: Colors.white.withOpacity(0.85), height: 1.4)),
        ),
      ],
    );
  }
}
