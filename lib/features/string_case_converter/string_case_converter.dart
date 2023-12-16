import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum _Case {
  upper,
  lower,
  camel,
  snake;
}

class StringCaseCoverter extends StatefulWidget {
  const StringCaseCoverter({super.key});

  @override
  State<StringCaseCoverter> createState() => _StringCaseCoverterState();
}

class _StringCaseCoverterState extends State<StringCaseCoverter> {
  String _input = '';
  String _output = '';

  _Case _targetCase = _Case.upper;

  void copyOutput() {
    Clipboard.setData(ClipboardData(text: _output));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );
  }

  final _caseRegex = RegExp(r'[_\-\s]+');

  String get convertedText {
    switch (_targetCase) {
      case _Case.upper:
        return _input.toUpperCase();
      case _Case.lower:
        return _input.toLowerCase();
      case _Case.camel:
        return _input
            // replace large case with space + small case
            .replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}')
            .split(_caseRegex)
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join();
      case _Case.snake:
        return _input
            .replaceAllMapped(
              RegExp(r'[A-Z]'),
              (match) => '_${match.group(0)}',
            )
            .split(_caseRegex)
            .map(
              (word) => word.toLowerCase(),
            )
            .join('_');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Enter some text and convert it to the target case',
          ),
          onChanged: (value) {
            setState(() {
              _input = value;
              _output = convertedText;
            });
          },
        ),
        DropdownButton<_Case>(
          value: _targetCase,
          onChanged: (value) {
            setState(() {
              _targetCase = value!;
              _output = convertedText;
            });
          },
          items: const [
            DropdownMenuItem(
              value: _Case.upper,
              child: Text('UPPERCASE'),
            ),
            DropdownMenuItem(
              value: _Case.lower,
              child: Text('lowercase'),
            ),
            DropdownMenuItem(
              value: _Case.camel,
              child: Text('camelCase'),
            ),
            DropdownMenuItem(
              value: _Case.snake,
              child: Text('snake_case'),
            ),
          ],
        ),
        Text(_output),
        ElevatedButton(
          onPressed: copyOutput,
          child: const Text('Copy to clipboard'),
        ),
      ],
    );
  }
}
