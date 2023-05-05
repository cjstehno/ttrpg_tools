import 'dart:math';

import 'package:quiver/collection.dart';
import 'package:quiver/core.dart';

const diceSpecEx = '([0-9]*)d([0-9]*)([+|-]?[0-9]*)';
final _defaultRandom = Random.secure();

/// Defines the dice to be rolled.
///
/// - `number`: the number of of dice to be rolled (0 or greater)
/// - `die`: the die to be rolled
/// - `modifier`: the modifier to be added to the result of the rolls
///
/// The `die` is rolled `number` times and then the `modifier` is added to it.
class Dice {
  final int number;
  final int die;
  final int modifier;

  /// Creates a dice object with the specified [number], [die], and [modifier]
  /// to be used.
  Dice(this.number, this.die, this.modifier);

  /// Retrieves the standard (average default) value for the defined dice.
  int get standard => (number * (die ~/ 2)) + modifier;

  /// Retrieves the lowest value that can be rolled by these dice.
  int get low => number + modifier;

  /// Retrieves the highest value that can be rolled by these dice.
  int get high => (number * die) + modifier;

  @override
  String toString() =>
      '${number}d$die${modifier > 0 ? '+' : ''}${modifier != 0 ? modifier : ''}';

  /// Used to convert a string specification of dice into a Dice object.
  ///
  /// The `string` must be in the form `NdD+M` where `N` is the `number`, `D` is
  /// the `die`, and `M` is the modifier. If there is no modifier, it may be
  /// omitted.
  ///
  /// *Example:*
  /// "3d6+4" will be converted to `Dice(3,6,4)`.
  static Dice fromSpec(final String spec) {
    final firstMatch = RegExp(diceSpecEx).allMatches(spec).first;
    final n = firstMatch.group(1);
    final d = firstMatch.group(2);
    final m = firstMatch.group(3);

    return Dice(
      n!.isNotEmpty ? int.parse(n) : 1,
      int.parse(d!),
      m!.isNotEmpty ? int.parse(m) : 0,
    );
  }
}

/// The results of rolling dice, containing the actual rolled values as well as
/// the provided multiplier.
class RollResults {
  final List<int> rolls;
  final int modifier;

  /// Creates a results object with the given [rolls] and [modifier].
  RollResults(this.rolls, this.modifier);

  /// Retrieves the value from the results, i.e. the sum of all the rolls and
  /// the modifier.
  int get value => rolls.reduce((value, element) => value + element) + modifier;

  /// Creates a string representation of the results in the form "S = (R...) + M"
  /// where S is the sum of the rolls and modifier, R is an array containing
  /// each rolled value, and M is the modifier.
  @override
  String toString() =>
      '$value\t= (${rolls.join(' + ')}) ${modifier >= 0 ? '+' : '-'} $modifier';

  @override
  bool operator ==(other) =>
      other is RollResults &&
      listsEqual(rolls, other.rolls) &&
      modifier == other.modifier;

  @override
  int get hashCode => hash2(rolls, modifier);
}

/// Rolls the specified [dice] using the provided [random] (or the default if
/// one is not provided).
RollResults roll(final Dice dice, {final Random? random}) {
  final rng = random ?? _defaultRandom;

  if (dice.number > 0) {
    return RollResults(
      Iterable<int>.generate(dice.number)
          .toList()
          .map((e) => rng.nextInt(dice.die) + 1)
          .toList(),
      dice.modifier,
    );
  } else {
    // you have effectively rolled no dice
    return RollResults([0], dice.modifier);
  }
}

/// Converts the specified `diceSpec` into a Dice object and rolls the dice.
RollResults rolls(final String diceSpec, {final Random? random}) =>
    roll(Dice.fromSpec(diceSpec), random: random);
