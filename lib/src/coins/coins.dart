import 'package:quiver/core.dart';

/*
  pp -> gp -> ep -> sp -> cp (X)
        10    2     5     10

  cp -> sp -> ep -> gp -> pp (/)
     10    5     2     10
 */
const _downwardConversions = [10, 2, 5, 10];
const _upwardConversions = [1, 10, 5, 2, 10];

enum CoinType implements Comparable<CoinType> {
  pp,
  gp,
  ep,
  sp,
  cp;

  @override
  int compareTo(final CoinType other) => index.compareTo(other.index);

  bool operator <(final CoinType other) => index < other.index;

  bool operator >(final CoinType other) => index > other.index;
}

extension CoinTypeExtension on CoinType {
  /// Returns the coin multiplier used to convert this coin type into copper
  /// pieces.
  ///
  /// 1 pp = 1000 cp
  /// 1 gp = 100 cp
  /// 1 ep = 50 cp
  /// 1 sp = 10 cp
  /// 1 cp = 1 cp
  ///
  int get multiplier {
    switch (this) {
      case CoinType.pp:
        return 1000;
      case CoinType.gp:
        return 100;
      case CoinType.ep:
        return 50;
      case CoinType.sp:
        return 10;
      case CoinType.cp:
        return 1;
    }
  }
}

class Coinage implements Comparable<Coinage> {
  final int number;
  final CoinType type;

  const Coinage(this.number, this.type);

  int get coppers {
    return number * type.multiplier;
  }

  @override
  String toString() => "${number} ${type.name}";

  @override
  int compareTo(final Coinage other) => type.compareTo(other.type);

  @override
  bool operator ==(other) =>
      other is Coinage && number == other.number && type == other.type;

  @override
  int get hashCode => hash2(number, type);
}

/// Given an amount of one coin type, convert it to the specified `newType` and
/// return the value of the coins in the new type with any remainder in the
/// original coin type.
List<Coinage> convert(final Coinage original, final CoinType newType) {
  if (original.type < newType) {
    int conversion = 1;

    int index = original.type.index;
    bool notFound = true;
    while (notFound) {
      conversion = conversion * _downwardConversions[index];

      index++;
      notFound = CoinType.values[index] != newType;
    }

    return [Coinage(original.number * conversion, newType)];
  } else if (original.type > newType) {
    int conversion = 1;

    int index = original.type.index;
    bool notFound = true;
    while (notFound) {
      conversion = conversion * _upwardConversions[index];

      index--;
      notFound = CoinType.values[index] != newType;
    }

    final newCoins = (original.number / conversion).toInt();
    final remaining = original.number % conversion;

    return [Coinage(newCoins, newType), Coinage(remaining, original.type)];
  } else {
    return [original];
  }
}

// FIXME: given a set of coins, calculate how much it weights
// float coinWeight(final List<Coinage> coins)
// 50 coins = 1 lb

/// Determines the total weight of the provided collection of coins, in pounds.
/// The determination is based on the standard of 50 coins equalling 1 pound.
double weight(final List<Coinage> coins) {
  return weightByCount(
    coins.map((c) => c.number).fold(0, (prev, cur) => prev + cur),
  );
}

/// Determines the total weight of the given number of coins, in pounds.
/// The determination is based on the standard of 50 coins equalling 1 pound.
double weightByCount(final int coinCount) {
  return coinCount / 50;
}
