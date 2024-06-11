import "package:flutter/material.dart";
import "package:weather_app/weather_screen.dart";

class SearchPage extends StatefulWidget {
  final Function(String) onCityChanged;
  const SearchPage({
    super.key,
    required this.onCityChanged,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> cities = [
    "Chennai",
    "Madurai",
    "Bangalore",
    "Mumbai",
    "Delhi",
    "Hyderabad",
    "Ahmedabad",
    "Kolkata",
    "Surat",
    "Pune",
    "Jaipur",
    "Lucknow",
    "Kanpur",
    "Nagpur",
    "Indore",
    "Thane",
    "Bhopal",
    "Visakhapatnam",
    "Pimpri-Chinchwad",
    "Patna",
    "Vadodara",
    "Ghaziabad",
    "Ludhiana",
    "Agra",
    "Nashik",
    "Faridabad",
    "Meerut",
    "Rajkot",
    "Kalyan-Dombivali",
    "Vasai-Virar",
    "Varanasi",
    "Srinagar",
    "Aurangabad",
    "Dhanbad",
    "Amritsar",
    "Navi Mumbai",
    "Allahabad",
    "Howrah",
    "Ranchi",
    "Jabalpur",
    "Gwalior",
    "Coimbatore",
    "Vijayawada",
    "Jodhpur",
    "Raipur",
    "Kota",
  ];

  List<String> matches = [
    "Chennai",
    "Madurai",
    "Bangalore",
    "Mumbai",
    "Delhi",
    "Hyderabad",
    "Ahmedabad",
    "Kolkata",
    "Surat",
    "Pune",
    "Jaipur",
    "Lucknow",
    "Kanpur",
    "Nagpur",
    "Indore",
    "Thane",
    "Bhopal",
    "Visakhapatnam",
    "Pimpri-Chinchwad",
    "Patna",
    "Vadodara",
    "Ghaziabad",
    "Ludhiana",
    "Agra",
    "Nashik",
    "Faridabad",
    "Meerut",
    "Rajkot",
    "Kalyan-Dombivali",
    "Vasai-Virar",
    "Varanasi",
    "Srinagar",
    "Aurangabad",
    "Dhanbad",
    "Amritsar",
    "Navi Mumbai",
    "Allahabad",
    "Howrah",
    "Ranchi",
    "Jabalpur",
    "Gwalior",
    "Coimbatore",
    "Vijayawada",
    "Jodhpur",
    "Raipur",
    "Kota",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 1, 1, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 1, 1, 1),
        leading: IconButton(
          padding: const EdgeInsets.all(25),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                setState(() {
                  matches.clear();
                  for (String city in cities) {
                    if (city.toLowerCase().contains(text.toLowerCase())) {
                      matches.add(city);
                    }
                  }
                });
              },
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "S E A R C H",
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const Divider(
              height: 0.5,
              thickness: 0.8,
              color: Color.fromRGBO(63, 63, 63, 1),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: InkWell(
                        onTap: () {
                          setState(() {
                            city = matches[index];
                          });
                          widget.onCityChanged(city);
                          Navigator.pop(context);
                        },
                        child: Text(
                          matches[index].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 10,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
