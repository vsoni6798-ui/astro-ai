import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_provider.dart';
import '../services/notification_service.dart';
import '../widgets/star_background.dart';
import '../theme/app_theme.dart';
import 'birth_chart_screen.dart';
import 'onboarding_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final sign = user.zodiacSign;

    return Scaffold(
      body: StarBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text('Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: sign.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(sign.symbol, style: TextStyle(fontSize: 40, color: sign.primaryColor)),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name ?? 'Guest',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('${sign.name} · Born ${user.birthDate?.month}/${user.birthDate?.day}/${user.birthDate?.year}',
                            style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _menuTile(
                context,
                icon: Icons.pie_chart_outline,
                title: 'Birth Chart',
                subtitle: 'View your natal chart analysis',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const BirthChartScreen()),
                ),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                value: user.notificationsEnabled,
                onChanged: (v) async {
                  await user.setNotifications(v);
                  if (v) {
                    await NotificationService.scheduleDailyReminder();
                  } else {
                    await NotificationService.cancelAll();
                  }
                },
                title: const Text('Daily Horoscope Notifications'),
                subtitle: const Text('Get a reminder every morning', style: TextStyle(fontSize: 12)),
                activeColor: AppTheme.starGold,
                tileColor: AppTheme.midnight,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              const SizedBox(height: 10),
              _menuTile(
                context,
                icon: Icons.edit_outlined,
                title: 'Edit Profile',
                subtitle: 'Update your name or birth date',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text('Astrology & Horoscope · v1.0.0',
                    style: TextStyle(color: Colors.white38, fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppTheme.mysticPurple),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.white60)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white38),
      tileColor: AppTheme.midnight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
