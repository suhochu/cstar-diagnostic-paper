import 'package:cstarimage_testpage/widgets/textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    Key? key,
    required this.hint,
    required this.items,
    required this.onSave,
    required this.onChanged,
    this.validator,
    this.textSize = 18,
    this.hintSize = 16,
    this.buttonHeight = 30,
    this.iconSize = 24,
    this.value,
  }) : super(key: key);
  final String hint;
  final List<String> items;
  final void Function(Object? object) onSave;
  final void Function(Object? object) onChanged;
  final String? Function(String?)? validator;
  final double textSize;
  final double hintSize;
  final double buttonHeight;
  final double iconSize;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String?>(
      value: value,
      decoration: textFieldInputDecoration(),
      isExpanded: false,
      hint: Text(
        hint,
        style: TextStyle(fontSize: hintSize, color: Colors.redAccent),
      ),
      isDense: true,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: iconSize,
      buttonHeight: buttonHeight,
      buttonPadding: const EdgeInsets.only(left: 3, right: 3),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Center(
                  child: SizedBox(
                    child: Text(
                      item,
                      style: TextStyle(fontSize: textSize, color: Colors.blueGrey),
                    ),
                  ),
                ),
              ))
          .toList(),
      onChanged: onChanged,
      onSaved: onSave,
      validator: validator,
      itemPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
