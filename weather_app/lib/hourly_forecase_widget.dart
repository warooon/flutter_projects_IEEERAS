import 'package:flutter/material.dart';

class HourlyForecastWidget extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;
  const HourlyForecastWidget(
      {super.key, required this.time, required this.icon, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Center(
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(63, 63, 63, 1)),
            ),
            const SizedBox(height: 5),
            Icon(
              icon,
              color: Colors.white,
              size: 25,
            ),
            const SizedBox(height: 5),
            Text(
              temp,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
