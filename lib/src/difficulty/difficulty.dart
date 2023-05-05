import 'package:ttrpg_tools/src/difficulty/challenge.dart';
import 'package:ttrpg_tools/src/difficulty/thresholds.dart';

/// Calculates an estimate of the difficulty for an encounter for a party of the
/// specified levels against a collection of creatures with the given challenge
/// ratings.
///
/// - `partyLevels`: the levels of each party member, one entry per character.
/// - `creatures`: the challenge rating for each creature, one per creature.
///
/// The number of creatures and the number of party members will also be used as
/// part of the calculation.
Difficulty estimateDifficulty(
  final List<Challenge> creatures,
  final List<int> partyLevels,
) {
  return thresholdForLevels(partyLevels)
      .resolve(calculateChallengeXp(creatures, partyLevels.length));
}
