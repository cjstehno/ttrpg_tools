import 'dart:math';

import 'package:quiver/check.dart';

/// Representation of the available Challenge Rating (CR) values.
enum Challenge {
  cr0,
  crEighth,
  crQuarter,
  crHalf,
  cr1,
  cr2,
  cr3,
  cr4,
  cr5,
  cr6,
  cr7,
  cr8,
  cr9,
  cr10,
  cr11,
  cr12,
  cr13,
  cr14,
  cr15,
  cr16,
  cr17,
  cr18,
  cr19,
  cr20,
  cr21,
  cr22,
  cr23,
  cr24,
  cr25,
  cr26,
  cr27,
  cr28,
  cr29,
  cr30;

  @override
  String toString() {
    switch (this) {
      case Challenge.crEighth:
        return "CR-1/8";
      case Challenge.crQuarter:
        return "CR-1/4";
      case Challenge.crHalf:
        return "CR-1/2";
      default:
        return name.replaceFirst("cr", "CR-");
    }
  }
}

extension ChallengeRatingExtension on Challenge {
  int get xp {
    switch (this) {
      case Challenge.cr0:
        return 10;
      case Challenge.crEighth:
        return 25;
      case Challenge.crQuarter:
        return 50;
      case Challenge.crHalf:
        return 100;
      case Challenge.cr1:
        return 200;
      case Challenge.cr2:
        return 450;
      case Challenge.cr3:
        return 700;
      case Challenge.cr4:
        return 1100;
      case Challenge.cr5:
        return 1800;
      case Challenge.cr6:
        return 2300;
      case Challenge.cr7:
        return 2900;
      case Challenge.cr8:
        return 3900;
      case Challenge.cr9:
        return 5000;
      case Challenge.cr10:
        return 5900;
      case Challenge.cr11:
        return 7200;
      case Challenge.cr12:
        return 8400;
      case Challenge.cr13:
        return 10000;
      case Challenge.cr14:
        return 11500;
      case Challenge.cr15:
        return 13000;
      case Challenge.cr16:
        return 15000;
      case Challenge.cr17:
        return 18000;
      case Challenge.cr18:
        return 20000;
      case Challenge.cr19:
        return 22000;
      case Challenge.cr20:
        return 25000;
      case Challenge.cr21:
        return 33000;
      case Challenge.cr22:
        return 41000;
      case Challenge.cr23:
        return 50000;
      case Challenge.cr24:
        return 62000;
      case Challenge.cr25:
        return 75000;
      case Challenge.cr26:
        return 90000;
      case Challenge.cr27:
        return 105000;
      case Challenge.cr28:
        return 120000;
      case Challenge.cr29:
        return 135000;
      case Challenge.cr30:
        return 155000;
    }
  }
}

const List<double> _multipliers = [1, 1.5, 2, 2.5, 3, 4];

/// Calculate the multiplier based on [number] of combatants, and the size of the
/// [party].
double multiplier(final int number, final int party) {
  int index = 1;
  if (number == 1) {
    index = 0;
  } else if (number == 2) {
    index = 1;
  } else if (number >= 3 && number <= 6) {
    index = 2;
  } else if (number >= 7 && number <= 10) {
    index = 3;
  } else if (number >= 11 && number <= 14) {
    index = 4;
  } else {
    index = 5;
  }

  // apply the party size adjustment
  if (party < 3) {
    index++;
  } else if (party >= 6) {
    index--;
  }

  // make sure the index is in bounds
  index = min(index, 5);
  index = max(index, 0);

  return _multipliers[index];
}

/// Calculates the total XP for the list of challenge ratings, while also taking
/// the number of creatures into consideration.
/// If there are fewer than three, or six or more in the party, this is also taken
/// into consideration.
int calculateChallengeXp(final List<Challenge> crs, final int party) {
  checkArgument(crs.isNotEmpty, message: "CR list cannot be empty.");

  final total =
      crs.map((cr) => cr.xp).fold(0, (prev, xp) => (prev as int) + xp);

  return (total * multiplier(crs.length, party)).toInt();
}
