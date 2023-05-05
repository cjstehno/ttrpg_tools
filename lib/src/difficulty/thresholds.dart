import 'package:quiver/check.dart';
import 'package:quiver/core.dart';

/// Representation of the encounter difficulty rating.
enum Difficulty {
  Easy,
  Medium,
  Hard,
  Deadly;

  @override
  String toString() => name;
}

/// The collected XP threshold values for each difficulty level.
class XpThreshold {
  final int easy;
  final int medium;
  final int hard;
  final int deadly;

  const XpThreshold(this.easy, this.medium, this.hard, this.deadly);

  /// Determines the difficulty level based on the internal threshold values and
  /// the provided [xp] value.
  Difficulty resolve(final int xp) {
    if (deadly <= xp) {
      return Difficulty.Deadly;
    } else if (hard <= xp) {
      return Difficulty.Hard;
    } else if (medium <= xp) {
      return Difficulty.Medium;
    } else {
      return Difficulty.Easy;
    }
  }

  @override
  String toString() => "XpThreshold($easy, $medium, $hard, $deadly})";

  @override
  bool operator ==(other) =>
      other is XpThreshold &&
      easy == other.easy &&
      medium == other.medium &&
      hard == other.hard &&
      deadly == other.deadly;

  @override
  int get hashCode => hash4(
        easy.hashCode,
        medium.hashCode,
        hard.hashCode,
        deadly.hashCode,
      );

  /// Adds the given XpThreshold object to this one and returns the summed value.
  XpThreshold operator +(o) => XpThreshold(
        o.easy + easy,
        o.medium + medium,
        o.hard + hard,
        o.deadly + deadly,
      );
}

// level = index + 1
const _thresholds = [
  XpThreshold(25, 50, 75, 100),
  XpThreshold(50, 100, 150, 200),
  XpThreshold(75, 150, 225, 400),
  XpThreshold(125, 250, 375, 500),
  XpThreshold(250, 500, 750, 1100),
  XpThreshold(300, 600, 900, 1400),
  XpThreshold(350, 750, 1100, 1700),
  XpThreshold(450, 900, 1400, 2100),
  XpThreshold(550, 1100, 1600, 2400),
  XpThreshold(600, 1200, 1900, 2800),
  XpThreshold(800, 1600, 2400, 3600),
  XpThreshold(1000, 2000, 3000, 4500),
  XpThreshold(1100, 2200, 3400, 5100),
  XpThreshold(1250, 2500, 3800, 5700),
  XpThreshold(1400, 2800, 4300, 6400),
  XpThreshold(1600, 3200, 4800, 7200),
  XpThreshold(2000, 3900, 5900, 8800),
  XpThreshold(2100, 4200, 6300, 9500),
  XpThreshold(2400, 4900, 7300, 10900),
  XpThreshold(2800, 5700, 8500, 12700),
];

/// Resolves the XP threshold for the specified [level] (between 1 and 20).
XpThreshold thresholdForLevel(final int level) {
  checkArgument(
    level > 0 && level <= 20,
    message: "Level must be between 1 and 20.",
  );

  return _thresholds[level - 1];
}

/// Resolves the sum of the XP thresholds for the levels (between 1 and 20)
/// specified in the list.
XpThreshold thresholdForLevels(final List<int> levels) {
  checkArgument(levels.isNotEmpty, message: "Level list cannot be empty.");

  return levels.fold(XpThreshold(0, 0, 0, 0), (previousValue, element) {
    return previousValue + thresholdForLevel(element);
  });
}
