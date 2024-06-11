import 'package:flutter/material.dart';
import 'package:vshare/resources/Colors.dart';

class SnackBarComponent {
  static showSnackBar(BuildContext context, String variant, String text) {
    Map variants = {
      "warning": [
        "Warning",
        Colors.yellow,
        "https://cdn-icons-png.flaticon.com/128/4539/4539472.png"
      ],
      "error": [
        "Alert",
        Colors.red,
        "https://cdn-icons-png.flaticon.com/128/4201/4201973.png"
      ],
      "success": [
        "Success",
        Colors.green,
        "https://cdn-icons-png.flaticon.com/128/7518/7518748.png"
      ],
    };

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primaryColor,
          ),
          child: Row(
            children: [
              Container(
                height: 75,
                width: 10,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(-20),
                    topRight: Radius.circular(-20),
                  ),
                  color: variants[variant][1],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Image(
                    width: 70,
                    image: NetworkImage(variants[variant][2]),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        variants[variant][0],
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "PoppinsRegular",
                            fontSize: 13),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        )));
  }
}
