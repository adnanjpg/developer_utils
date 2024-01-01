import 'package:developer_utils/utils/utils.dart';
import 'package:developer_utils/widgets/field_output_item.dart';
import 'package:flutter/material.dart';
import 'package:life_saver_extensions/life_saver_extensions.dart';

class PercentageCalculator extends StatefulWidget {
  const PercentageCalculator({super.key});

  @override
  State<PercentageCalculator> createState() => _PercentageCalculatorState();
}

class _PercentageCalculatorState extends State<PercentageCalculator> {
  double? get parts => double.tryParse(partsController?.text ?? '');
  double? get whole => double.tryParse(wholeController?.text ?? '');
  double? get percentage => double.tryParse(percentageController?.text ?? '');

  TextEditingController? partsController, wholeController, percentageController;

  @override
  initState() {
    super.initState();

    partsController = TextEditingController(
      text: '',
    );
    wholeController = TextEditingController(
      text: '',
    );
    percentageController = TextEditingController(
      text: '',
    );
  }

  void recalcPercentage() {
    final v1 = parts;
    final v2 = whole;

    if (v1 == null || v2 == null) {
      return;
    }

    final v3 = v1 / v2 * 100;

    percentageController?.text = v3.toString();
  }

  void recalcParts() {
    final v2 = whole;
    final v3 = percentage;

    if (v2 == null || v3 == null) {
      return;
    }

    final v1 = v2 * v3 / 100;

    partsController?.text = v1.toString();
  }

  void onPartsChanged(String value) {
    recalcPercentage();
  }

  void onWholeChanged(String value) {
    recalcPercentage();
  }

  void onPercentageChanged(String value) {
    recalcParts();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FieldOutputItem(
                  title: 'Parts',
                  text: parts.toString(),
                  textFormField: TextFormField(
                    controller: partsController,
                    onChanged: onPartsChanged,
                  ),
                ),
              ),
              Expanded(
                child: FieldOutputItem(
                  title: 'Whole',
                  text: whole.toString(),
                  textFormField: TextFormField(
                    controller: wholeController,
                    onChanged: onWholeChanged,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: FieldOutputItem(
                  title: 'Percentage',
                  text: percentage.toString(),
                  textFormField: TextFormField(
                    controller: percentageController,
                    onChanged: onPercentageChanged,
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ].joinWidgetList(
          (_) => defVerticalSeperator,
        ),
      ),
    );
  }
}
