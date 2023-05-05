import 'package:test/test.dart';

void parameterizedTest(
  final List<dynamic> arguments,
  final String groupLabel,
  final Function testBody, {
  final Function? labelFactory,
}) {
  group(groupLabel, () {
    for (var args in arguments) {
      final label = labelFactory == null ? args.toString() : labelFactory(args);
      test(label, () => testBody(args));
    }
  });
}
