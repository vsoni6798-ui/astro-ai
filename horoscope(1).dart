enum HoroscopePeriod { daily, weekly, monthly }

class Horoscope {
  final String signName;
  final HoroscopePeriod period;
  final String general;
  final String love;
  final String career;
  final String health;
  final int luckyNumber;
  final String luckyColor;
  final double compatibilityScore; // 0-100, mood/energy score for the period

  const Horoscope({
    required this.signName,
    required this.period,
    required this.general,
    required this.love,
    required this.career,
    required this.health,
    required this.luckyNumber,
    required this.luckyColor,
    required this.compatibilityScore,
  });
}

class CompatibilityResult {
  final String signA;
  final String signB;
  final int score; // 0-100
  final String summary;
  final String loveNote;
  final String friendshipNote;

  const CompatibilityResult({
    required this.signA,
    required this.signB,
    required this.score,
    required this.summary,
    required this.loveNote,
    required this.friendshipNote,
  });
}
