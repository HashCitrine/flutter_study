import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/chat_chef/constants/palette.dart';
import 'package:flutter_study/chat_chef/constants/form_type.dart';

class HomeFormField<T> extends StatelessWidget {
  final int keyVal;
  final Icon icon;
  final String hint;
  final FormFieldValidator<String> validator;
  late String val;
  final FormType type;
  HomeFormField({super.key, required this.keyVal, required this.icon, required this.hint, required this.validator, required this.type});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) {
        val = newValue!;
      },
      onChanged: (value) {
        val = value;
      },
      obscureText: FormType.password == type ? true : false,
      keyboardType: setKeyboard(type),
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

  String get value {
    return val;
  }

  TextInputType setKeyboard(FormType type) {
    switch (type) {
      case FormType.email:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }
}
