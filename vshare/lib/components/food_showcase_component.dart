// ignore_for_file: must_be_immutable

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:url_launcher/url_launcher.dart";
import "package:vshare/pages/food_image_viewer_page.dart";
import "package:vshare/resources/Colors.dart";

class FoodShowcaseComponent extends StatelessWidget {
  String id;
  String foodName;
  String foodQuantity;
  LatLng location;
  String donatorId;
  String donatorName;
  String date;
  String time;
  List images;
  int donatorPoints;
  late String imageUrl;

  FoodShowcaseComponent({
    super.key,
    required this.foodName,
    required this.foodQuantity,
    required this.location,
    required this.donatorId,
    required this.donatorName,
    required this.date,
    required this.time,
    required this.images,
    required this.donatorPoints,
    required this.id,
  });

  void openMap() async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}';

    Uri uriParsedUrl = Uri.parse(googleUrl);
    if (await canLaunchUrl(uriParsedUrl)) {
      await launchUrl(uriParsedUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (donatorPoints >= 0 && donatorPoints <= 10) {
      imageUrl =
          "https://imgs.search.brave.com/jQ9T_wjltnrmqjNnbwuSmoh5N2cz8AAXJCbUXUN6pac/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9uZnQt/bW9ua2V5LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMy8w/My85M2YxMTQyNjlk/NWM4YTZkYWNiY2Y1/ODdlNGI0YzQ5My0x/LnBuZw";
    } else if (donatorPoints >= 11 && donatorPoints <= 20) {
      imageUrl =
          "https://imgs.search.brave.com/o0ICtRhZSKkvkx1wJQm7UQ_99ma7mmtrYbE1CfMHnlo/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzBhL2Nj/LzJkLzBhY2MyZDhj/MDA2NGNiNjkyNmEz/MmM3YjE3ZDIxMDk1/LmpwZw";
    } else if (donatorPoints >= 21 && donatorPoints <= 30) {
      imageUrl =
          "https://imgs.search.brave.com/lPd9lHjfVpKOxmpe8hhSsYeXcBeTopYeREsAPb7j7Dg/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9uZnQt/bW9ua2V5LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMy8w/My9MYXllci0yLTEt/MS5wbmc";
    } else if (donatorPoints >= 31 && donatorPoints <= 40) {
      imageUrl =
          "https://imgs.search.brave.com/ahLyAgmCoh5TxcV_CxILPJKj7q-yqCNZp-r5g_UOGAY/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9uZnQt/bW9ua2V5LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMy8w/My9hNzZhYWIyNDFj/MWE4OWE4NTNmNDA3/Y2NlZTczMGE4Zi0x/LTEwMjR4MTAyNC5w/bmc";
    } else if (donatorPoints >= 41 && donatorPoints <= 50) {
      imageUrl =
          "https://imgs.search.brave.com/N91rB_d9U7WPwScFCA5KWTKVqJYPk7igr2tNOkIHqZ4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9uZnQt/bW9ua2V5LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMy8w/My8xNzIyN2Q5OGEx/YTk5YjVmYTIzMDUz/NGQyNDZkMTlhOC0x/LnBuZw";
    } else if (donatorPoints >= 51 && donatorPoints <= 60) {
      imageUrl =
          "https://imgs.search.brave.com/VLu-KwrK0troRiyGi6YFeeoMVNVdhMJO3eu1vdOX7Ew/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9uZnQt/bW9ua2V5LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMy8w/My8yLTEucG5n";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromRGBO(52, 91, 64, 1)),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print(images);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FoodImageViewerPage(images: images)));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                          width: 80,
                          height: 80,
                          image: NetworkImage(images[0])),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$foodName ($foodQuantity kgs)",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          openMap();
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 17,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Click to view Location",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "PoppinsRegular",
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Donated by",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "PoppinsRegular",
                                fontSize: 13),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            donatorName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "PoppinsSemiBold",
                                fontSize: 13),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          CircleAvatar(
                            minRadius: 10,
                            maxRadius: 10,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        ],
                      ),
                      Text(
                        "$date | $time",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "PoppinsRegular",
                            fontSize: 13),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      String uid = FirebaseAuth.instance.currentUser!.uid;
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(uid)
                          .get()
                          .then((snapshot) {
                        var snapData = snapshot.data();
                        FirebaseFirestore.instance
                            .collection("donations")
                            .doc(id)
                            .update({
                          "receiverName": snapData!["username"],
                          "receiverId": uid,
                          "bookedby": "booked",
                        });

                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(donatorId)
                            .update({
                          "points": FieldValue.increment(1),
                        });
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                          color: lightGreenColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Image(
                        width: 30,
                        image: NetworkImage(
                            "https://cdn-icons-png.flaticon.com/128/5906/5906139.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
