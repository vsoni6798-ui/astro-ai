import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_provider.dart';
import '../data/horoscope_generator.dart';
import '../models/horoscope.dart';
import '../widgets/star_background.dart';
import '../widgets/horoscope_section_card.dart';
import '../theme/app_theme.dart';

class HoroscopeScreen extends StatefulWidget {
  const HoroscopeScreen({super.key});

  @override
  State<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final sign = user.zodiacSign;

    return Scaffold(
      body: StarBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    Text(sign.symbol,
                        style: TextStyle(fontSize: 36, color: sign.primaryColor)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi ${user.name ?? "there"} 👋',
                            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
                          ),
                          Text(
                            '${sign.name} Horoscope',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: AppTheme.starGold,
                labelColor: AppTheme.starGold,
                unselectedLabelColor: Colors.white54,
                tabs: const [
                  Tab(text: 'Daily'),
                  Tab(text: 'Weekly'),
                  Tab(text: 'Monthly'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _HoroscopeView(signName: sign.name, period: HoroscopePeriod.daily),
                    _HoroscopeView(signName: sign.name, period: HoroscopePeriod.weekly),
                    _HoroscopeView(signName: sign.name, period: HoroscopePeriod.monthly),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HoroscopeView extends StatelessWidget {
  final String signName;
  final HoroscopePeriod period;

  const _HoroscopeView({required this.signName, required this.period});

  @override
  Widget build(BuildContext context) {
    final horoscope = HoroscopeGenerator.generate(signName: signName, period: period);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Lucky number / color banner
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.mysticPurple, AppTheme.deepSpace],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: _luckyStat('🍀 Lucky Number', '${horoscope.luckyNumber}'),
              ),
              Container(width: 1, height: 40, color: Colors.white24),
              Expanded(
                child: _luckyStat('🎨 Lucky Color', horoscope.luckyColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const Text('Energy Level', style: TextStyle(fontSize: 13, color: Colors.white70)),
              const SizedBox(width: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: horoscope.compatibilityScore / 100,
                    minHeight: 8,
                    backgroundColor: Colors.white12,
                    color: AppTheme.starGold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text('${horoscope.compatibilityScore.toInt()}%',
                  style: const TextStyle(fontSize: 12, color: Colors.white70)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        HoroscopeSectionCard(
          icon: Icons.auto_awesome,
          title: 'General',
          content: horoscope.general,
          accentColor: AppTheme.starGold,
        ),
        HoroscopeSectionCard(
          icon: Icons.favorite,
          title: 'Love',
          content: horoscope.love,
          accentColor: const Color(0xFFEC407A),
        ),
        HoroscopeSectionCard(
          icon: Icons.work_outline,
          title: 'Career & Finance',
          content: horoscope.career,
          accentColor: const Color(0xFF43A047),
        ),
        HoroscopeSectionCard(
          icon: Icons.spa_outlined,
          title: 'Health',
          content: horoscope.health,
          accentColor: const Color(0xFF00ACC1),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _luckyStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }
}
