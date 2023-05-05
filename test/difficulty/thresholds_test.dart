import 'package:ttrpg_tools/src/difficulty/thresholds.dart';
import 'package:test/test.dart';

void main() {
  group('XpThreshold:', () {
    final xpThreshold = XpThreshold(10, 20, 40, 80);

    test('expected values', () {
      expect(xpThreshold.easy, 10);
      expect(xpThreshold.medium, 20);
      expect(xpThreshold.hard, 40);
      expect(xpThreshold.deadly, 80);
    });

    test('equal value are equal', () {
      expect(xpThreshold, XpThreshold(10, 20, 40, 80));
    });

    test('non-equal values are not equal', () {
      expect(false, xpThreshold == XpThreshold(10, 25, 50, 100));
    });

    test('adding', () {
      expect(xpThreshold + XpThreshold(15, 25, 45, 80),
          XpThreshold(25, 45, 85, 160));
    });

    test('resolved for level', () {
      expect(thresholdForLevel(10), XpThreshold(600, 1200, 1900, 2800));
    });

    test('resolved for levels 1, 3, 4', () {
      expect(thresholdForLevels([1, 3, 4]), XpThreshold(225, 450, 675, 1000));
    });

    test('handle resolve with invalid level - < 1', () {
      expect(
        () => thresholdForLevel(0),
        throwsA(predicate(_isLevelBoundsError)),
      );
    });

    test('handle resolve with invalid level - > 20', () {
      expect(
        () => thresholdForLevel(21),
        throwsA(predicate(_isLevelBoundsError)),
      );
    });

    test('handle resolve levels with empty list', () {
      expect(
        () => thresholdForLevels([]),
        throwsA(predicate(_isEmptyListError)),
      );
    });

    for (var arg in _difficultyCalcArgs) {
      test('resolving difficulty with ${arg[0]} -> ${arg[1]}', () {
        expect(xpThreshold.resolve(arg[0] as int), arg[1]);
      });
    }
  });
}

bool _isLevelBoundsError(x) =>
    x is ArgumentError && x.message == "Level must be between 1 and 20.";

bool _isEmptyListError(x) =>
    x is ArgumentError && x.message == "Level list cannot be empty.";

const _difficultyCalcArgs = [
  [10, Difficulty.Easy],
  [15, Difficulty.Easy],
  [22, Difficulty.Medium],
  [39, Difficulty.Medium],
  [40, Difficulty.Hard],
  [55, Difficulty.Hard],
  [79, Difficulty.Hard],
  [80, Difficulty.Deadly],
  [125, Difficulty.Deadly],
];
