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
  }) : super(key: key);
  final String hint;
  final List<String> items;
  final void Function(Object? object) onSave;
  final void Function(Object? object) onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: textFieldInputDecoration(),
      isExpanded: false,
      hint: Text(
        hint,
        style: const TextStyle(fontSize: 20, color: Colors.redAccent),
      ),
      isDense: true,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 40,
      buttonPadding: const EdgeInsets.only(left: 3, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Center(
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 24, color: Colors.blueGrey),
                  ),
                ),
              ))
          .toList(),
      onChanged: onChanged,
      onSaved: onSave,
      validator: validator,
    );
  }
}
