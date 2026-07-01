import 'dart:math';
import '../models/horoscope.dart';
import '../models/zodiac_sign.dart';
import 'zodiac_data.dart';

/// Generates horoscope content locally using a seeded random generator,
/// so the same sign + date always produces the same reading (feels stable
/// to the user instead of changing on every app open).
///
/// PRODUCTION NOTE: Replace `_pick()` calls with a real astrology content
/// API or an LLM-generated feed (see services/ai_service.dart for how this
/// project wires up the Claude API for the AI Assistant tab — the same
/// pattern can generate horoscope copy server-side).
class HoroscopeGenerator {
  static const List<String> _generalTemplates = [
    'The stars encourage you to slow down and trust your instincts today. A small decision now could ripple into something bigger.',
    'Energy is shifting in your favor. Stay open to unexpected opportunities that cross your path.',
    'This is a good time to reflect before you act. Patience will serve you better than speed.',
    'A conversation today may reveal something you needed to hear. Listen closely.',
    'Your confidence is magnetic right now — use it to move a stalled project forward.',
    'Old patterns may resurface. This time, you have the clarity to respond differently.',
    'Focus on what you can control. The rest will fall into place with time.',
    'A fresh perspective from someone close to you could change how you see a challenge.',
  ];

  static const List<String> _loveTemplates = [
    'Emotional honesty strengthens your closest relationship today.',
    'Single? Someone from your everyday circle may catch your eye in a new light.',
    'A little vulnerability goes a long way with your partner right now.',
    'Old romantic tension resurfaces — decide if it is worth revisiting.',
    'Your charm is heightened; use it to repair, not just to attract.',
    'Give your relationship room to breathe rather than forcing a resolution.',
  ];

  static const List<String> _careerTemplates = [
    'A financial decision needs one more day of thought before you commit.',
    'Recognition for past effort may finally arrive — accept it graciously.',
    'Collaboration outperforms solo effort today; loop others in.',
    'A budgeting habit you start now will pay off within the month.',
    'Trust your read on a workplace situation — your instincts are sharp today.',
    'An unexpected expense calls for flexibility, not panic.',
  ];

  static const List<String> _healthTemplates = [
    'Your energy runs high in the morning — schedule demanding tasks early.',
    'Rest is productive too. Do not skip it in favor of pushing through.',
    'A short walk outside will clear your head more than caffeine will.',
    'Pay attention to tension in your shoulders and neck today.',
    'Hydration and a full night of sleep matter more than usual this week.',
    'Your mood and body are linked right now — movement will lift both.',
  ];

  static const List<String> _luckyColors = [
    'Emerald Green', 'Royal Blue', 'Crimson Red', 'Golden Yellow',
    'Lavender', 'Coral', 'Silver', 'Turquoise', 'Rose Pink', 'Amber'
  ];

  static int _seedFor(String signName, HoroscopePeriod period, DateTime date) {
    int periodBucket;
    switch (period) {
      case HoroscopePeriod.daily:
        periodBucket = date.year * 1000 + date.month * 31 + date.day;
        break;
      case HoroscopePeriod.weekly:
        final weekOfYear = ((date.difference(DateTime(date.year, 1, 1)).inDays) / 7).floor();
        periodBucket = date.year * 100 + weekOfYear;
        break;
      case HoroscopePeriod.monthly:
        periodBucket = date.year * 100 + date.month;
        break;
    }
    return signName.hashCode ^ periodBucket;
  }

  static Horoscope generate({
    required String signName,
    required HoroscopePeriod period,
    DateTime? forDate,
  }) {
    final date = forDate ?? DateTime.now();
    final rng = Random(_seedFor(signName, period, date));

    return Horoscope(
      signName: signName,
      period: period,
      general: _generalTemplates[rng.nextInt(_generalTemplates.length)],
      love: _loveTemplates[rng.nextInt(_loveTemplates.length)],
      career: _careerTemplates[rng.nextInt(_careerTemplates.length)],
      health: _healthTemplates[rng.nextInt(_healthTemplates.length)],
      luckyNumber: rng.nextInt(99) + 1,
      luckyColor: _luckyColors[rng.nextInt(_luckyColors.length)],
      compatibilityScore: (rng.nextInt(41) + 60).toDouble(), // 60-100 range, keeps it upbeat
    );
  }

  /// Simple deterministic compatibility score between two signs based on
  /// element affinity (fire/air and earth/water pair well; same element
  /// pairs are intense; opposing elements are a growth challenge).
  static CompatibilityResult compatibility(String signAName, String signBName) {
    final a = ZodiacData.byName(signAName);
    final b = ZodiacData.byName(signBName);

    int baseScore;
    if (a.name == b.name) {
      baseScore = 78; // same sign: deep understanding, mirrored flaws
    } else if (_sameGroup(a.element, b.element)) {
      baseScore = 88; // complementary elements
    } else if (a.element == b.element) {
      baseScore = 72; // same element: intense but can clash
    } else {
      baseScore = 58; // opposing elements: friction, but growth potential
    }

    final rng = Random(a.name.hashCode ^ b.name.hashCode);
    final score = (baseScore + rng.nextInt(11) - 5).clamp(30, 99);

    return CompatibilityResult(
      signA: a.name,
      signB: b.name,
      score: score,
      summary: score >= 80
          ? '${a.name} and ${b.name} share a natural rhythm — communication tends to flow with little friction.'
          : score >= 60
              ? '${a.name} and ${b.name} balance each other well, though it may take conscious effort to stay aligned.'
              : '${a.name} and ${b.name} approach life differently — this pairing rewards patience and open communication.',
      loveNote: score >= 80
          ? 'Romantically, this is an easy, energizing match.'
          : score >= 60
              ? 'Romantically, chemistry is there but needs nurturing.'
              : 'Romantically, this pairing is a slow burn that needs work.',
      friendshipNote: score >= 80
          ? 'As friends, expect loyalty and easy understanding.'
          : score >= 60
              ? 'As friends, you complement each other\'s blind spots.'
              : 'As friends, you may need to actively bridge different worldviews.',
    );
  }

  static bool _sameGroup(Element a, Element b) {
    const fireAir = {Element.fire, Element.air};
    const earthWater = {Element.earth, Element.water};
    return (fireAir.contains(a) && fireAir.contains(b) && a != b) ||
        (earthWater.contains(a) && earthWater.contains(b) && a != b);
  }
}
