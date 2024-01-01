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

  bool valForm() {
    final form = formKey.currentState;
    final v = form?.validate();

    return v == true;
  }

  void onV1Changed(String value) {
    if (!valForm()) {
      return;
    }

    recalcPercentage();
  }

  void onV2Changed(String value) {
    if (!valForm()) {
      return;
    }

    recalcPercentage();
  }

  void onV3Changed(String value) {
    if (!valForm()) {
      return;
    }

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
                    onChanged: onV1Changed,
                  ),
                ),
              ),
              Expanded(
                child: FieldOutputItem(
                  title: 'Whole',
                  text: whole.toString(),
                  textFormField: TextFormField(
                    controller: wholeController,
                    onChanged: onV2Changed,
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
                    onChanged: onV3Changed,
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
