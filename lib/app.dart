import 'package:developer_utils/features/byte_converter/byte_converter.dart';
import 'package:developer_utils/features/password_generator/password_generator.dart';
import 'package:developer_utils/features/percentage_calculator/percentage_calculator.dart';
import 'package:developer_utils/features/string_case_converter/string_case_converter.dart';
import 'package:developer_utils/features/unix_time_converter/unix_time_converter.dart';
import 'package:developer_utils/selected_tool_prov.dart';
import 'package:developer_utils/sidebar.dart';
import 'package:developer_utils/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TheApp extends StatelessWidget {
  const TheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          const AppSiderbar(),
          const VerticalDivider(
            thickness: .8,
          ),
          defHorizontalSeperator,
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final selectedTool = ref.watch(selectedToolProv);

                switch (selectedTool) {
                  case SelectedTool.stringCaseConverter:
                    return const StringCaseCoverter();
                  case SelectedTool.unixTimeConverter:
                    return const UnixTimeConverter();
                  case SelectedTool.passwordGenerator:
                    return const PasswordGenerator();
                  case SelectedTool.percentageCalculator:
                    return const PercentageCalculator();
                  case SelectedTool.byteConverter:
                    return const ByteConverter();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
