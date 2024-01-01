import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remixicon/remixicon.dart';

class FieldOutputItem extends StatelessWidget {
  final String title;
  final String text;
  final TextFormField? textFormField;
  const FieldOutputItem({
    super.key,
    required this.title,
    required this.text,
    this.textFormField,
  });

  void _copy(BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Row(
          children: [
            Expanded(
              child: textFormField ??
                  TextFormField(
                    initialValue: text,
                    readOnly: true,
                  ),
            ),
            SizedBox(
              width: 50,
              child: IconButton(
                icon: const Icon(Remix.file_copy_fill),
                onPressed: () => _copy(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
