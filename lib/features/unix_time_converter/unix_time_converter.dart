import 'package:developer_utils/utils/utils.dart';
import 'package:developer_utils/widgets/field_output_item.dart';
import 'package:flutter/material.dart';
import 'package:life_saver_extensions/life_saver_extensions.dart';
import 'package:timeago/timeago.dart' as timeago;

enum _TimeType {
  secondsFromEpoch,
  millisecondsFromEpoch,
  microsecondsFromEpoch,
  iso8601;

  String get name {
    switch (this) {
      case _TimeType.secondsFromEpoch:
        return 'Seconds from epoch';
      case _TimeType.millisecondsFromEpoch:
        return 'Milliseconds from epoch';
      case _TimeType.microsecondsFromEpoch:
        return 'Microseconds from epoch';
      case _TimeType.iso8601:
        return 'ISO8601';
    }
  }
}

class UnixTimeConverter extends StatefulWidget {
  const UnixTimeConverter({super.key});

  @override
  State<UnixTimeConverter> createState() => _UnixTimeConverterState();
}

class _UnixTimeConverterState extends State<UnixTimeConverter> {
  String _input = '';

  ({
    DateTime time,
    _TimeType type,
  })? get convertedOutput {
    // user may enter a unix time in seconds, milliseconds, microseconds, or an iso8601 string

    final intInp = int.tryParse(_input);

    if (intInp == null) {
      final iso8601 = DateTime.tryParse(_input);
      if (iso8601 != null) {
        return (
          time: iso8601,
          type: _TimeType.iso8601,
        );
      }

      return null;
    }

    final inpLen = _input.length;

    final isSeconds = inpLen == 10;

    if (isSeconds) {
      return (
        time: DateTime.fromMillisecondsSinceEpoch(intInp * 1000),
        type: _TimeType.secondsFromEpoch,
      );
    }

    final isMilliseconds = inpLen == 13;
    if (isMilliseconds) {
      return (
        time: DateTime.fromMillisecondsSinceEpoch(intInp),
        type: _TimeType.millisecondsFromEpoch,
      );
    }

    final isMicroseconds = inpLen == 16;
    if (isMicroseconds) {
      return (
        time: DateTime.fromMicrosecondsSinceEpoch(intInp),
        type: _TimeType.microsecondsFromEpoch,
      );
    }

    debugPrint('ERROR: invalid input');
    return null;
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final val = convertedOutput;

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText:
                  'Enter a 8601 string or a unix time of seconds, milliseconds, or microseconds',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }

              return null;
            },
            onChanged: (value) {
              formKey.currentState?.validate();
              setState(() {
                _input = value;
              });
            },
          ),
          if (val != null) ...[
            ListTile(
              title: Text(
                'Output type: ${val.type.name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: FieldOutputItem(
                    title: 'Local',
                    text: val.time.toIso8601String(),
                  ),
                ),
                Expanded(
                  child: FieldOutputItem(
                    title: 'UTC',
                    text: val.time.toUtc().toIso8601String(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FieldOutputItem(
                    title: 'Seconds from epoch',
                    text: (val.time.millisecondsSinceEpoch ~/ 1000).toString(),
                  ),
                ),
                Expanded(
                  child: FieldOutputItem(
                    title: 'Milliseconds from epoch',
                    text: val.time.millisecondsSinceEpoch.toString(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FieldOutputItem(
                    title: 'Microseconds from epoch',
                    text: val.time.microsecondsSinceEpoch.toString(),
                  ),
                ),
                Expanded(
                  child: FieldOutputItem(
                    title: 'Relative',
                    text: timeago.format(val.time),
                  ),
                ),
              ],
            ),
          ],
        ].joinWidgetList(
          (_) => defVerticalSeperator,
        ),
      ),
    );
  }
}
