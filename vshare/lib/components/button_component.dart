import "package:flutter/material.dart";
import "package:vshare/resources/Colors.dart";

class ButtonComponent extends StatelessWidget {
  const ButtonComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: yellowColor,
      ),
      child: const Center(
        child: Text(
          "Log In",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontFamily: "PoppinsSemiBold"),
        ),
      ),
    );
  }
}
