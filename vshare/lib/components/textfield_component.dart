// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:vshare/resources/Colors.dart";

class TextFieldComponent extends StatelessWidget {
  final String hintText;
  final icon;
  final TextEditingController textEditingController;
  final keyboardType;
  bool obscureText;
  TextFieldComponent({
    super.key,
    required this.hintText,
    required this.icon,
    required this.textEditingController,
    required this.keyboardType,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.transparent));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: textEditingController,
        cursorColor: greyColor,
        style: const TextStyle(
            color: greyColor, fontFamily: "PoppinsRegular", fontSize: 15),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          suffixIcon: icon,
          hintStyle: const TextStyle(
              color: greyColor, fontFamily: "PoppinsRegular", fontSize: 15),
          hintText: hintText,
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          fillColor: lighterGreenColor,
          filled: true,
        ),
      ),
    );
  }
}
