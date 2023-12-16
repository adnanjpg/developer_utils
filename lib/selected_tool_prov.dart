import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SelectedTool {
  stringCaseConverter;
}

final selectedToolProv = StateProvider<SelectedTool>(
  (ref) {
    return SelectedTool.stringCaseConverter;
  },
);
