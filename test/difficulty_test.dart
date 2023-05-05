import 'package:ttrpg_tools/ttrpg_tools.dart';
import 'package:test/test.dart';

void main() {
  group('Difficulty:', () {

    // FIXME: better testing
    test('estimate', (){
      final diff = estimateDifficulty(
        [Challenge.cr2],
        [1,2,1,2]
      );

      expect(diff, Difficulty.Hard);
    });

    test('estimate', (){
      final diff = estimateDifficulty(
          [Challenge.cr20],
          [1,2,1,2]
      );

      expect(diff, Difficulty.Deadly);
    });
  });
}
