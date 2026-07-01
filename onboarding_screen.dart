import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_provider.dart';
import '../data/zodiac_data.dart';
import '../widgets/star_background.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _nameController = TextEditingController();
  DateTime? _birthDate;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 25, now.month, now.day),
      firstDate: DateTime(now.year - 100),
      lastDate: now,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AppTheme.mysticPurple,
                onPrimary: Colors.white,
                surface: AppTheme.midnight,
              ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
  }

  void _continue() async {
    if (_nameController.text.trim().isEmpty || _birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name and birth date.')),
      );
      return;
    }
    await context.read<UserProvider>().saveProfile(
          name: _nameController.text.trim(),
          birthDate: _birthDate!,
        );
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final previewSign =
        _birthDate != null ? ZodiacData.fromBirthDate(_birthDate!) : null;

    return Scaffold(
      body: StarBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text('✨', style: TextStyle(fontSize: 40)),
                const SizedBox(height: 12),
                Text(
                  'Let\'s personalize\nyour astrology',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'We use your birth date to calculate your zodiac sign and tailor your readings.',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Your name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.midnight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.cake_outlined),
                        const SizedBox(width: 12),
                        Text(
                          _birthDate == null
                              ? 'Select your birth date'
                              : '${_birthDate!.month}/${_birthDate!.day}/${_birthDate!.year}',
                          style: TextStyle(
                            color: _birthDate == null
                                ? Colors.white54
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (previewSign != null) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: previewSign.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Text(previewSign.symbol,
                            style: TextStyle(fontSize: 32, color: previewSign.primaryColor)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'You are a ${previewSign.name}!',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _continue,
                    child: const Text('Reveal My Chart'),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
