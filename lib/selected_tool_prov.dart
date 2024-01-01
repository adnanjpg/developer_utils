import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SelectedTool {
  stringCaseConverter,
  unixTimeConverter,
  passwordGenerator,
  percentageCalculator,
  byteConverter,
}

final selectedToolProv = StateProvider<SelectedTool>(
  (ref) {
    return SelectedTool.stringCaseConverter;
  },
);
