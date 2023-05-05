import 'package:ttrpg_tools/ttrpg_tools.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  parameterizedTest(
    _coinsToCoppersArgs,
    'Converting to cp:',
    labelFactory: (a) => "${a[0]} to cp -> ${a[1]}",
    (args) {
      expect(
        (args[0] as Coinage).coppers,
        args[1] as int,
      );
    },
  );

  parameterizedTest(
    _convertDownwardArgs,
    'Converting from one type to another (downward):',
    labelFactory: (a) => "${a[0]} to ${(a[1] as CoinType).name} -> ${a[2]}",
    (args) {
      expect(
        convert(
          args[0] as Coinage,
          args[1] as CoinType,
        ),
        args[2] as List<dynamic>,
      );
    },
  );

  parameterizedTest(
    _convertUpwardArgs,
    'Converting from one type to another (upward):',
    labelFactory: (a) => "${a[0]} to ${(a[1] as CoinType).name} -> ${a[2]}",
    (args) {
      expect(
        convert(
          args[0] as Coinage,
          args[1] as CoinType,
        ),
        args[2] as List<dynamic>,
      );
    },
  );

  parameterizedTest(
    _coinWeightArgs,
    'Calculating coin weight:',
    labelFactory: (a) => "${a[0]} -> ${a[1]} pounds",
    (args) => expect(weight(args[0]), args[1]),
  );
}

const _coinWeightArgs = [
  [
    [Coinage(10, CoinType.gp), Coinage(100, CoinType.sp)],
    2.2
  ],
  [
    [Coinage(1, CoinType.gp), Coinage(1, CoinType.sp)],
    0.04
  ],
  [
    [Coinage(123, CoinType.gp), Coinage(123, CoinType.sp)],
    4.92
  ],
];

const _coinsToCoppersArgs = [
  [Coinage(1, CoinType.pp), 1000],
  [Coinage(2, CoinType.pp), 2000],
  [Coinage(1, CoinType.gp), 100],
  [Coinage(3, CoinType.gp), 300],
  [Coinage(1, CoinType.ep), 50],
  [Coinage(4, CoinType.ep), 200],
  [Coinage(1, CoinType.sp), 10],
  [Coinage(5, CoinType.sp), 50],
  [Coinage(1, CoinType.cp), 1],
  [Coinage(6, CoinType.cp), 6],
];

const _convertDownwardArgs = [
  // FIXME: more testing

  // downward
  [
    Coinage(1, CoinType.pp),
    CoinType.pp,
    [Coinage(1, CoinType.pp)]
  ],
  [
    Coinage(1, CoinType.pp),
    CoinType.gp,
    [Coinage(10, CoinType.gp)]
  ],
  [
    Coinage(1, CoinType.pp),
    CoinType.ep,
    [Coinage(20, CoinType.ep)]
  ],
  [
    Coinage(1, CoinType.pp),
    CoinType.sp,
    [Coinage(100, CoinType.sp)]
  ],
  [
    Coinage(1, CoinType.pp),
    CoinType.cp,
    [Coinage(1000, CoinType.cp)]
  ],

  [
    Coinage(1, CoinType.gp),
    CoinType.sp,
    [Coinage(10, CoinType.sp)]
  ],
  [
    Coinage(1, CoinType.sp),
    CoinType.cp,
    [Coinage(10, CoinType.cp)]
  ],
  [
    Coinage(1, CoinType.ep),
    CoinType.sp,
    [Coinage(5, CoinType.sp)]
  ],
];

const _convertUpwardArgs = [
  // FIXME: more testing

  // upward
  [
    Coinage(123, CoinType.cp),
    CoinType.cp,
    [Coinage(123, CoinType.cp)]
  ],
  [
    Coinage(123, CoinType.cp),
    CoinType.sp,
    [Coinage(12, CoinType.sp), Coinage(3, CoinType.cp)]
  ],
  [
    Coinage(123, CoinType.cp),
    CoinType.gp,
    [Coinage(1, CoinType.gp), Coinage(23, CoinType.cp)]
  ],
  [
    Coinage(12, CoinType.gp),
    CoinType.pp,
    [Coinage(1, CoinType.pp), Coinage(2, CoinType.gp)]
  ]
];
