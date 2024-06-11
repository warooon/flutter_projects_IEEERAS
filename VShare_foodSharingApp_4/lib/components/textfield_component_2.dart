// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:vshare/resources/Colors.dart";

class TextFieldComponent2 extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  TextFieldComponent2(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.transparent));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        cursorColor: greyColor,
        style: const TextStyle(
            color: Colors.white, fontFamily: "PoppinsRegular", fontSize: 15),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: const TextStyle(
              color: greyColor, fontFamily: "PoppinsRegular", fontSize: 15),
          fillColor: const Color.fromRGBO(52, 90, 65, 1),
          filled: true,
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
        ),
      ),
    );
  }
}
