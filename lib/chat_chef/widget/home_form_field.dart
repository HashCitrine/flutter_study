import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/chat_chef/constants/Palette.dart';

class HomeFormField<T> extends StatelessWidget {
  final int keyVal;
  final Icon icon;
  final String hint;
  final FormFieldValidator<String> validator;
  late String val;
  HomeFormField({super.key, required this.keyVal, required this.icon, required this.hint, required this.validator});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) {
        val = newValue!;
      },
      key: ValueKey(keyVal),
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: icon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Palette.textColor1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(35.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Palette.textColor1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(35.0),
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Palette.textColor1,
        ),
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
