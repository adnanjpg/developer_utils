import 'package:developer_utils/utils/utils.dart';
import 'package:developer_utils/widgets/field_output_item.dart';
import 'package:flutter/material.dart';
import 'package:life_saver_extensions/life_saver_extensions.dart';

class ByteConverter extends StatefulWidget {
  const ByteConverter({super.key});

  @override
  State<ByteConverter> createState() => _ByteConverterState();
}

class _ByteConverterState extends State<ByteConverter> {
  int? get bits => int.tryParse(bitsController.text);
  int? get bytes => int.tryParse(bytesController.text);
  int? get kilobytes => int.tryParse(kilobytesController.text);
  int? get megabytes => int.tryParse(megabytesController.text);
  int? get gigabytes => int.tryParse(gigabytesController.text);
  int? get terabytes => int.tryParse(terabytesController.text);
  int? get petabytes => int.tryParse(petabytesController.text);
  int? get exabytes => int.tryParse(exabytesController.text);

  late TextEditingController bitsController,
      bytesController,
      kilobytesController,
      megabytesController,
      gigabytesController,
      terabytesController,
      petabytesController,
      exabytesController;

  @override
  initState() {
    super.initState();

    bitsController = TextEditingController(
      text: '',
    );
    bytesController = TextEditingController(
      text: '',
    );
    kilobytesController = TextEditingController(
      text: '',
    );
    megabytesController = TextEditingController(
      text: '',
    );
    gigabytesController = TextEditingController(
      text: '',
    );
    terabytesController = TextEditingController(
      text: '',
    );
    petabytesController = TextEditingController(
      text: '',
    );
    exabytesController = TextEditingController(
      text: '',
    );
  }

  int bitToByte(int bits) => bits ~/ 8;
  int bitToKilobyte(int bits) => bits ~/ 8 ~/ 1024;
  int bitToMegabyte(int bits) => bits ~/ 8 ~/ 1024 ~/ 1024;
  int bitToGigabyte(int bits) => bits ~/ 8 ~/ 1024 ~/ 1024 ~/ 1024;
  int bitToTerabyte(int bits) => bits ~/ 8 ~/ 1024 ~/ 1024 ~/ 1024 ~/ 1024;
  int bitToPetabyte(int bits) =>
      bits ~/ 8 ~/ 1024 ~/ 1024 ~/ 1024 ~/ 1024 ~/ 1024;
  int bitToExabyte(int bits) =>
      bits ~/ 8 ~/ 1024 ~/ 1024 ~/ 1024 ~/ 1024 ~/ 1024 ~/ 1024;

  int byteToBit(int bytes) => bytes * 8;
  int kilobyteToBit(int kilobytes) => kilobytes * 1024 * 8;
  int megabyteToBit(int megabytes) => megabytes * 1024 * 1024 * 8;
  int gigabyteToBit(int gigabytes) => gigabytes * 1024 * 1024 * 1024 * 8;
  int terabyteToBit(int terabytes) => terabytes * 1024 * 1024 * 1024 * 1024 * 8;
  int petabyteToBit(int petabytes) =>
      petabytes * 1024 * 1024 * 1024 * 1024 * 1024 * 8;
  int exabyteToBit(int exabytes) =>
      exabytes * 1024 * 1024 * 1024 * 1024 * 1024 * 1024 * 8;

  void recalc({
    required int newBits,
  }) {
    bitsController.text = newBits.toString();

    int bits = newBits;

    bytesController.text = bitToByte(bits).toString();
    kilobytesController.text = bitToKilobyte(bits).toString();
    megabytesController.text = bitToMegabyte(bits).toString();
    gigabytesController.text = bitToGigabyte(bits).toString();
    terabytesController.text = bitToTerabyte(bits).toString();
    petabytesController.text = bitToPetabyte(bits).toString();
    exabytesController.text = bitToExabyte(bits).toString();
  }

  void onBitsChanged(String value) {
    final newBits = int.tryParse(value);
    if (newBits == null) return;

    recalc(
      newBits: newBits,
    );
  }

  void onBytesChanged(String value) {
    final newBytes = int.tryParse(value);
    if (newBytes == null) return;
    final newBits = byteToBit(newBytes);

    recalc(
      newBits: newBits,
    );
  }

  void onKilobytesChanged(String value) {
    final newKilobytes = int.tryParse(value);
    if (newKilobytes == null) return;

    final newBits = kilobyteToBit(newKilobytes);

    recalc(
      newBits: newBits,
    );
  }

  void onMegabytesChanged(String value) {
    final newMegabytes = int.tryParse(value);
    if (newMegabytes == null) return;

    final newBits = megabyteToBit(newMegabytes);

    recalc(
      newBits: newBits,
    );
  }

  void onGigabytesChanged(String value) {
    final newGigabytes = int.tryParse(value);
    if (newGigabytes == null) return;

    final newBits = gigabyteToBit(newGigabytes);

    recalc(
      newBits: newBits,
    );
  }

  void onTerabytesChanged(String value) {
    final newTerabytes = int.tryParse(value);
    if (newTerabytes == null) return;

    final newBits = terabyteToBit(newTerabytes);

    recalc(
      newBits: newBits,
    );
  }

  void onPetabytesChanged(String value) {
    final newPetabytes = int.tryParse(value);
    if (newPetabytes == null) return;

    final newBits = petabyteToBit(newPetabytes);

    recalc(
      newBits: newBits,
    );
  }

  void onExabytesChanged(String value) {
    final newExabytes = int.tryParse(value);
    if (newExabytes == null) return;

    final newBits = exabyteToBit(newExabytes);

    recalc(
      newBits: newBits,
    );
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
                  title: 'Bits',
                  text: bits.toString(),
                  textFormField: TextFormField(
                    controller: bitsController,
                    onChanged: onBitsChanged,
                  ),
                ),
              ),
              Expanded(
                child: FieldOutputItem(
                  title: 'Bytes',
                  text: bytes.toString(),
                  textFormField: TextFormField(
                    controller: bytesController,
                    onChanged: onBytesChanged,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: FieldOutputItem(
                  title: 'Kilobytes',
                  text: kilobytes.toString(),
                  textFormField: TextFormField(
                    controller: kilobytesController,
                    onChanged: onKilobytesChanged,
                  ),
                ),
              ),
              Expanded(
                child: FieldOutputItem(
                  title: 'Megabytes',
                  text: megabytes.toString(),
                  textFormField: TextFormField(
                    controller: megabytesController,
                    onChanged: onMegabytesChanged,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: FieldOutputItem(
                  title: 'Gigabytes',
                  text: gigabytes.toString(),
                  textFormField: TextFormField(
                    controller: gigabytesController,
                    onChanged: onGigabytesChanged,
                  ),
                ),
              ),
              Expanded(
                child: FieldOutputItem(
                  title: 'Terabytes',
                  text: terabytes.toString(),
                  textFormField: TextFormField(
                    controller: terabytesController,
                    onChanged: onTerabytesChanged,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: FieldOutputItem(
                  title: 'Petabytes',
                  text: petabytes.toString(),
                  textFormField: TextFormField(
                    controller: petabytesController,
                    onChanged: onPetabytesChanged,
                  ),
                ),
              ),
              Expanded(
                child: FieldOutputItem(
                  title: 'Exabytes',
                  text: exabytes.toString(),
                  textFormField: TextFormField(
                    controller: exabytesController,
                    onChanged: onExabytesChanged,
                  ),
                ),
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
