import 'package:developer_utils/selected_tool_prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSiderbar extends ConsumerWidget {
  const AppSiderbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    onSelected(SelectedTool tool) {
      ref.read(selectedToolProv.notifier).state = tool;
    }

    final items = [
      (
        id: 'string_case_converter',
        title: 'String Case Converter',
        onPressed: () => onSelected(SelectedTool.stringCaseConverter),
      ),
      (
        id: 'unix_time_converter',
        title: 'Unix Time Converter',
        onPressed: () => onSelected(SelectedTool.unixTimeConverter),
      )
    ];
    return SizedBox(
      width: 200,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.title),
            onTap: item.onPressed,
          );
        },
      ),
    );
  }
}
