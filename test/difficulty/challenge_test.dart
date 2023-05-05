import 'package:ttrpg_tools/src/difficulty/challenge.dart';
import 'package:test/test.dart';

void main() {
  group('ChallengeRatings:', () {
    test('xp for cr', () {
      expect(Challenge.cr7.xp, 2900);
      expect(Challenge.cr14.xp, 11500);
    });

    test('string for CR', () {
      expect(Challenge.cr20.toString(), "CR-20");
      expect(Challenge.crEighth.toString(), "CR-1/8");
      expect(Challenge.crQuarter.toString(), "CR-1/4");
      expect(Challenge.crHalf.toString(), "CR-1/2");
    });

    for (var arg in _challengeCalcArgs) {
      test('calculate for ${arg[0]}', () {
        expect(
          calculateChallengeXp(arg[0] as List<Challenge>, 4),
          arg[1],
        );
      });
    }

    test('empty list of CRs', () {
      expect(
        () => calculateChallengeXp([], 4),
        throwsA(predicate(_isEmptyListError)),
      );
    });

    for (var arg in _multiplierCalcArgs) {
      test('multiplier for ${arg[0]} against ${arg[1]} -> ${arg[2]}', () {
        expect(multiplier(arg[0] as int, arg[1] as int), arg[2]);
      });
    }
  });
}

bool _isEmptyListError(x) =>
    x is ArgumentError && x.message == "CR list cannot be empty.";

// Parameterized args for the challenge calculation test
const List<dynamic> _challengeCalcArgs = [
  [
    [Challenge.cr1],
    200
  ],
  [
    [Challenge.cr1, Challenge.cr3],
    1350
  ],
  [
    [
      Challenge.cr1,
      Challenge.cr3,
      Challenge.cr3,
      Challenge.cr4,
    ],
    5400
  ],
  [
    [
      Challenge.cr1,
      Challenge.cr1,
      Challenge.cr1,
      Challenge.cr3,
      Challenge.cr3,
      Challenge.cr4,
      Challenge.cr4,
    ],
    10500
  ],
  [
    [
      Challenge.cr1,
      Challenge.cr1,
      Challenge.cr1,
      Challenge.cr1,
      Challenge.cr3,
      Challenge.cr3,
      Challenge.cr3,
      Challenge.cr3,
      Challenge.cr4,
      Challenge.cr4,
      Challenge.cr10,
    ],
    35100
  ],
  [
    [
      Challenge.cr1,
      Challenge.cr1,
      Challenge.cr1,
      Challenge.cr1,
      Challenge.cr1,
      Challenge.cr1,
      Challenge.cr3,
      Challenge.cr3,
      Challenge.cr3,
      Challenge.cr3,
      Challenge.cr3,
      Challenge.cr4,
      Challenge.cr4,
      Challenge.cr4,
      Challenge.cr10,
    ],
    55600
  ],
];

const List<dynamic> _multiplierCalcArgs = [
  // creatures, party, expected
  [1, 4, 1],
  [1, 1, 1.5],
  [1, 10, 1],

  [2, 4, 1.5],
  [2, 1, 2],
  [2, 10, 1],

  [4, 4, 2],
  [4, 1, 2.5],
  [4, 10, 1.5],

  [8, 4, 2.5],
  [8, 1, 3],
  [8, 10, 2],

  [12, 4, 3],
  [12, 1, 4],
  [12, 10, 2.5],

  [16, 4, 4],
  [16, 1, 4],
  [16, 10, 3],
];
