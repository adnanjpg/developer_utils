import 'dart:math';

import 'package:developer_utils/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_saver_extensions/life_saver_extensions.dart';
import 'package:remixicon/remixicon.dart';

enum _PasswordGeneratorMode {
  allChars,
  easyToRead,
  easyToSay,
}

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  State<PasswordGenerator> createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  static const _minLen = 1;
  static const _defaultLen = 12;
  static const _maxLen = 50;

  int len = _defaultLen;

  bool _useLowercase = true;
  bool _useUppercase = true;
  bool _useNumbers = true;
  bool _useSymbols = true;

  _PasswordGeneratorMode _mode = _PasswordGeneratorMode.allChars;

  String _generatePassword() {
    final chars = <String>[];

    if (_useLowercase) {
      chars.addAll('abcdefghijklmnopqrstuvwxyz'.split(''));
    }

    if (_useUppercase) {
      chars.addAll('ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split(''));
    }

    if (_useNumbers) {
      chars.addAll('0123456789'.split(''));
    }

    if (_useSymbols) {
      chars.addAll('!@#\$%^&*()_+-=[]{};:,./<>?'.split(''));
    }

    final random = Random();
    final password = <String>[];

    for (var i = 0; i < len; i++) {
      password.add(chars[random.nextInt(chars.length)]);
    }

    return password.join('');
  }

  String _generatedPassword = '';

  void _regeneratePassword() {
    setState(() {
      _generatedPassword = _generatePassword();
    });
  }

  @override
  void initState() {
    super.initState();

    _generatedPassword = _generatePassword();
  }

  void copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _generatedPassword));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );
  }

  final lenController = TextEditingController(
    text: _defaultLen.toString(),
  );

  void onLenChanged(String value) {
    final parsed = int.tryParse(value);

    if (parsed == null) {
      return;
    }

    if (parsed < _minLen) {
      lenController.text = _minLen.toString();
      return;
    }

    if (parsed > _maxLen) {
      lenController.text = _maxLen.toString();
      return;
    }

    lenController.text = parsed.toString();

    setState(() => len = int.parse(value));
    _regeneratePassword();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                key: ValueKey(_generatedPassword),
                initialValue: _generatedPassword,
                readOnly: true,
              ),
            ),
            IconButton(
              onPressed: _regeneratePassword,
              icon: const Icon(Remix.refresh_fill),
            ),
            IconButton(
              onPressed: () => copyToClipboard(context),
              icon: const Icon(Remix.file_copy_2_fill),
            ),
          ],
        ),
        Column(
          children: [
            const Text('Password Length'),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: lenController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: onLenChanged,
                  ),
                ),
                Expanded(
                  child: Slider.adaptive(
                    value: len.toDouble(),
                    onChanged: (val) => onLenChanged(
                      val.floor().toString(),
                    ),
                    min: _minLen.toDouble(),
                    max: _maxLen.toDouble(),
                    divisions: _maxLen - _minLen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ].joinWidgetList(
        (_) => defVerticalSeperator,
      ),
    );
  }
}
