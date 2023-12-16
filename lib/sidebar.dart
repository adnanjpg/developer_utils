import 'package:flutter/material.dart';

class AppSiderbar extends StatelessWidget {
  const AppSiderbar({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        id: 'string_case_converter',
        title: 'String Case Converter',
        onPressed: () {},
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
