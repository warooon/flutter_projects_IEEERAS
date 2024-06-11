import "dart:convert";

import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:weather_app/additional_info_widget.dart";

import "package:weather_app/hourly_forecase_widget.dart";

import "package:http/http.dart" as http;
import "package:intl/intl.dart";
import "package:weather_app/search_page.dart";

String city = "Chennai";

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final box = Hive.box("cityBox");

  void getCity() {
    if (box.containsKey(1)) {
      city = box.get(1);
    } else {
      box.put(1, "Chennai");
      city = "Chennai";
    }
  }

  void writeCity(String city) {
    box.delete(1);
    box.put(1, city);
  }

  @override
  void initState() {
    super.initState();
    getCity();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String api =
          "4daefceb9188df71af651f1c6a67c754"; // get ur api key from openweather.com
      final result = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$api"));

      final data = jsonDecode(result.body);
      if (data['cod'] != "200") {
        throw "Error occured while calling the API";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String dateMonthYear =
        DateFormat("EEEE, dd MMMM yyyy").format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 1, 1, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 1, 1, 1),
        centerTitle: true,
        title: Text(
          dateMonthYear,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(63, 63, 63, 1)),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.manage_search_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchPage(
                          onCityChanged: (newCity) {
                            setState(() {
                              city = newCity;
                            });
                            writeCity(city);
                          },
                        )));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                getCurrentWeather();
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          if (snapshot.hasError) {
            return const Text("Some error occured, try refreshing!");
          }

          final data = snapshot.data!;
          final String temperature =
              (data["list"][0]["main"]["temp"] - 273.15).toStringAsFixed(0);
          final String weather = data["list"][0]["weather"][0]["main"];
          final IconData icon;

          if (weather == "Clouds") {
            icon = Icons.cloud_outlined;
          } else if (weather == "Rain") {
            icon = Icons.beach_access_sharp;
          } else {
            icon = Icons.sunny;
          }

          final String temperatureMax =
              (data["list"][0]["main"]["temp_min"] - 273.15).toStringAsFixed(0);
          final String temperatureMin =
              (data["list"][0]["main"]["temp_max"] - 273.15).toStringAsFixed(0);

          final String windSpeedValue =
              data["list"][0]["wind"]["speed"].toString();
          final String pressureValue =
              data["list"][0]["main"]["pressure"].toString();
          final String humidityValue =
              data["list"][0]["main"]["humidity"].toString();

          return Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    city.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 10),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    weather.toUpperCase(),
                    style: const TextStyle(
                        letterSpacing: 10,
                        color: Color.fromRGBO(172, 172, 172, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 80,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "$temperature°",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 90,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 15),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "max",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(63, 63, 63, 1)),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "$temperatureMax°",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                          child: SizedBox(
                            width: 40,
                            child: VerticalDivider(
                              thickness: 1.5,
                              color: Color.fromRGBO(63, 63, 63, 1),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const Text(
                              "min",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(63, 63, 63, 1)),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "$temperatureMin°",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                  const Divider(
                    height: 0.5,
                    thickness: 0.8,
                    color: Color.fromRGBO(63, 63, 63, 1),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        final time =
                            DateTime.parse(data["list"][index + 1]["dt_txt"]);

                        final String weatherType =
                            data["list"][index + 1]["weather"][0]["main"];
                        final IconData iconType;
                        if (weatherType == "Clouds") {
                          iconType = Icons.cloud_outlined;
                        } else if (weatherType == "Rain") {
                          iconType = Icons.beach_access_sharp;
                        } else {
                          iconType = Icons.sunny;
                        }
                        final String temp =
                            (data["list"][index + 1]["main"]["temp"] - 273.15)
                                .toStringAsFixed(0);

                        return HourlyForecastWidget(
                            time:
                                "${DateFormat("EEEE").format(time).substring(0, 3)}, ${DateFormat("hh:mm a").format(time)}",
                            icon: iconType,
                            temp: "$temp°");
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    height: 0.5,
                    thickness: 0.4,
                    color: Color.fromRGBO(63, 63, 63, 1),
                  ),
                  const SizedBox(height: 15),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AdditionalInfoWidget(
                          additionalInfoType: "wind speed",
                          additionalInfoValue: "$windSpeedValue m/s",
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                          child: SizedBox(
                            child: VerticalDivider(
                              thickness: 1.5,
                              color: Color.fromRGBO(63, 63, 63, 1),
                            ),
                          ),
                        ),
                        AdditionalInfoWidget(
                          additionalInfoType: "pressure",
                          additionalInfoValue: pressureValue,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                          child: SizedBox(
                            child: VerticalDivider(
                              thickness: 1.5,
                              color: Color.fromRGBO(63, 63, 63, 1),
                            ),
                          ),
                        ),
                        AdditionalInfoWidget(
                          additionalInfoType: "humidity",
                          additionalInfoValue: "$humidityValue%",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
