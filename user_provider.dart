import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/zodiac_sign.dart';
import '../data/zodiac_data.dart';

/// Holds the user's profile (name, birth date, derived zodiac sign) and
/// persists it locally with shared_preferences so it survives app restarts.
class UserProvider extends ChangeNotifier {
  String? name;
  DateTime? birthDate;
  bool notificationsEnabled = true;
  bool _loaded = false;

  bool get hasProfile => birthDate != null;
  bool get isLoaded => _loaded;

  ZodiacSign get zodiacSign =>
      birthDate != null ? ZodiacData.fromBirthDate(birthDate!) : ZodiacData.signs.first;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('user_name');
    final millis = prefs.getInt('user_birth_date');
    if (millis != null) {
      birthDate = DateTime.fromMillisecondsSinceEpoch(millis);
    }
    notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    _loaded = true;
    notifyListeners();
  }

  Future<void> saveProfile({required String name, required DateTime birthDate}) async {
    this.name = name;
    this.birthDate = birthDate;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setInt('user_birth_date', birthDate.millisecondsSinceEpoch);
    notifyListeners();
  }

  Future<void> setNotifications(bool enabled) async {
    notificationsEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', enabled);
    notifyListeners();
  }

  Future<void> clearProfile() async {
    name = null;
    birthDate = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    await prefs.remove('user_birth_date');
    notifyListeners();
  }
}
