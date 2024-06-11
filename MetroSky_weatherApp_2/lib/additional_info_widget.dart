import 'package:flutter/material.dart';

class AdditionalInfoWidget extends StatelessWidget {
  final String additionalInfoType;
  final String additionalInfoValue;
  const AdditionalInfoWidget(
      {super.key,
      required this.additionalInfoType,
      required this.additionalInfoValue});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        additionalInfoType,
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(63, 63, 63, 1)),
      ),
      const SizedBox(height: 10),
      Text(
        additionalInfoValue,
        style: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal),
      ),
    ]);
  }
}
