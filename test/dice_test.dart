import 'dart:math';

import 'package:ttrpg_tools/ttrpg_tools.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  parameterizedTest(_objectArgs, 'Dice (object)', (args) {
    final rolled = roll(args[0] as Dice, random: _knownRandom());
    expect(rolled, args[1]);
    expect(rolled.toString(), args[2]);
  });

  parameterizedTest(_stringArgs, 'Dice (string):', (args) {
    final rolled = rolls(args[0] as String, random: _knownRandom());
    expect(rolled, args[1]);
    expect(rolled.toString(), args[2]);
  });

  group('Unusual dice:', () {
    test('2d7', () {
      expect(
          roll(Dice(2, 7, 0), random: _knownRandom()), RollResults([3, 6], 0));
    });

    test('2d30', () {
      expect(roll(Dice(2, 30, 0), random: _knownRandom()),
          RollResults([26, 29], 0));
    });
  });

  group('Dice stats:', () {
    final dice = Dice(3, 10, 3);

    test('Standard roll', () {
      expect(dice.standard, 18);
    });
    test('Low roll', () {
      expect(dice.low, 6);
    });
    test('High roll', () {
      expect(dice.high, 33);
    });
  });
}

final _objectArgs = _stringArgs
    .map((a) => [
          Dice.fromSpec(a[0] as String),
          a[1],
          a[2],
        ])
    .toList();

final _stringArgs = [
  [
    '3d6',
    RollResults([2, 5, 3], 0),
    "10	= (2 + 5 + 3) + 0"
  ],
  [
    'd6',
    RollResults([2], 0),
    "2	= (2) + 0"
  ],
  [
    '1d6',
    RollResults([2], 0),
    "2	= (2) + 0"
  ],
  [
    '0d6',
    RollResults([0], 0),
    "0	= (0) + 0"
  ],
  [
    '0d6+5',
    RollResults([0], 5),
    "5	= (0) + 5"
  ],
  [
    '3d8+5',
    RollResults([8, 3, 5], 5),
    "21	= (8 + 3 + 5) + 5"
  ],
];

Random _knownRandom() => Random(8675309);
