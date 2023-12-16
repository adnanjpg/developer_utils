import 'dart:math';

import 'package:developer_utils/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_saver_extensions/life_saver_extensions.dart';
import 'package:remixicon/remixicon.dart';

enum _PasswordGeneratorMode {
  allChars,
  easyToRead,
  easyToSay;

  String get name {
    switch (this) {
      case _PasswordGeneratorMode.allChars:
        return 'All Characters';
      case _PasswordGeneratorMode.easyToRead:
        return 'Easy to Read';
      case _PasswordGeneratorMode.easyToSay:
        return 'Easy to Say';
    }
  }

  String get tooltipInfo {
    switch (this) {
      case _PasswordGeneratorMode.allChars:
        return 'Any character combinations like ~!@#\$%^&*()_+-=[]{};:,./<>?';
      case _PasswordGeneratorMode.easyToRead:
        return 'Avoid ambiguous characters like 1lI0oO';
      case _PasswordGeneratorMode.easyToSay:
        return 'Avoid numbers and special characters';
    }
  }
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

  bool _useNumbersIsDisabled = false;
  bool _useSymbolsIsDisabled = false;

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

    if (_mode == _PasswordGeneratorMode.easyToRead) {
      final ambigousChars = '1l0IoOIsS5Z2B8'.split('');
      chars.removeWhere((char) => ambigousChars.contains(char));
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

  bool get isWeak => len < 12;

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
              icon: const Icon(Remix.refresh_line),
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
                    activeColor: isWeak ? Colors.red[800] : null,
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
        Row(
          children: [
            Expanded(
              child: Column(
                children: _PasswordGeneratorMode.values.map(
                  (mode) {
                    final title = mode.name;

                    return RadioListTile<_PasswordGeneratorMode>.adaptive(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title),
                          Tooltip(
                            message: mode.tooltipInfo,
                            child: const Icon(
                              Remix.information_line,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      value: mode,
                      groupValue: _mode,
                      onChanged: (val) {
                        if (val == _PasswordGeneratorMode.easyToSay) {
                          _useSymbols = false;
                          _useNumbers = false;
                          _useNumbersIsDisabled = true;
                          _useSymbolsIsDisabled = true;
                        } else {
                          if (val == _PasswordGeneratorMode.allChars) {
                            _useLowercase = true;
                            _useUppercase = true;
                            _useNumbers = true;
                            _useSymbols = true;
                          }

                          _useNumbersIsDisabled = false;
                          _useSymbolsIsDisabled = false;
                        }
                        setState(() => _mode = val!);
                        _regeneratePassword();
                      },
                    );
                  },
                ).toList(),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  CheckboxListTile.adaptive(
                    value: _useLowercase,
                    title: const Text('Lowercase'),
                    onChanged: (val) {
                      setState(() => _useLowercase = val!);
                      _regeneratePassword();
                    },
                  ),
                  CheckboxListTile.adaptive(
                    value: _useUppercase,
                    title: const Text('Uppercase'),
                    onChanged: (val) {
                      setState(() => _useUppercase = val!);
                      _regeneratePassword();
                    },
                  ),
                  CheckboxListTile.adaptive(
                    value: _useNumbers,
                    title: const Text('Numbers'),
                    onChanged: _useNumbersIsDisabled
                        ? null
                        : (val) {
                            setState(() => _useNumbers = val!);
                            _regeneratePassword();
                          },
                  ),
                  CheckboxListTile.adaptive(
                    value: _useSymbols,
                    title: const Text('Symbols'),
                    onChanged: _useSymbolsIsDisabled
                        ? null
                        : (val) {
                            setState(() => _useSymbols = val!);
                            _regeneratePassword();
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ].joinWidgetList(
        (_) => defVerticalSeperator,
      ),
    );
  }
}
