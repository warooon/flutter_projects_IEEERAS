import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:provider/provider.dart";
import "package:vshare/components/food_showcase_component.dart";
import "package:vshare/components/track_food_showcase_component.dart";
import "package:vshare/resources/Colors.dart";
import "package:vshare/services/firebase_updation.dart";
import "package:vshare/services/food_available_modal.dart";
import "package:vshare/services/track_food_modal.dart";

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    FirebaseUpdation.listenToFoodAvailable(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final foodAvailabelProvider =
        Provider.of<FoodAvailableModal>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGreenColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSize.height * 0.3,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: SizedBox(
                        width: screenSize.width * 0.6,
                        height: screenSize.height * 0.3,
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: Image(
                            fit: BoxFit.contain,
                            image:
                                AssetImage("assets/images/homepageimage.png"),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 15,
                      child: SizedBox(
                        width: screenSize.width * 0.3,
                        height: screenSize.height * 0.2,
                        child: const Align(
                          alignment: Alignment.topLeft,
                          child: Image(
                            fit: BoxFit.contain,
                            image: AssetImage("assets/images/knife.png"),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                        top: 180,
                        left: 15,
                        child: Text(
                          "Grab it!",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 30),
                        )),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: 200 *
                        foodAvailabelProvider.foodAvailable.length.toDouble(),
                    child: ListView.builder(
                      itemCount: foodAvailabelProvider.foodAvailable.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<dynamic>(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(foodAvailabelProvider.foodAvailable[index]
                                  ["donatorId"])
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(
                                color: lightGreenColor,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                !snapshot.data!.exists) {
                              return const CircularProgressIndicator(
                                color: lightGreenColor,
                              );
                            } else {
                              var donatorData = snapshot.data!.data();

                              return FoodShowcaseComponent(
                                images: foodAvailabelProvider
                                    .foodAvailable[index]["images"],
                                id: foodAvailabelProvider.foodAvailable[index]
                                    ["id"],
                                foodName: foodAvailabelProvider
                                    .foodAvailable[index]["name"],
                                foodQuantity: foodAvailabelProvider
                                    .foodAvailable[index]["quantity"],
                                location: LatLng(
                                  foodAvailabelProvider.foodAvailable[index]
                                      ["location"][0],
                                  foodAvailabelProvider.foodAvailable[index]
                                      ["location"][1],
                                ),
                                donatorId: foodAvailabelProvider
                                    .foodAvailable[index]["donatorId"],
                                donatorName: donatorData["username"],
                                date: foodAvailabelProvider.foodAvailable[index]
                                    ["date"],
                                time: foodAvailabelProvider.foodAvailable[index]
                                    ["time"],
                                donatorPoints: donatorData["points"],
                              );
                            }
                          },
                        );
                      },
                    ),
                  )),
              const TrackFoods(),
            ],
          ),
        ),
      ),
    );
  }
}

class TrackFoods extends StatefulWidget {
  const TrackFoods({super.key});

  @override
  State<TrackFoods> createState() => _TrackFoodsState();
}

class _TrackFoodsState extends State<TrackFoods> {
  bool trackFoodDropDown = true;

  @override
  void initState() {
    super.initState();
    FirebaseUpdation.listenToFoodsToTrack(context);
  }

  @override
  Widget build(BuildContext context) {
    final trackFoodProvider = Provider.of<TrackFoodModal>(context);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Track Food",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 18),
              ),
              trackFoodDropDown == false
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          trackFoodDropDown = !trackFoodDropDown;
                        });
                      },
                      child: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          trackFoodDropDown = !trackFoodDropDown;
                        });
                      },
                      child: const Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white,
                      ),
                    )
            ],
          ),
          trackFoodDropDown == true
              ? SizedBox(
                  height:
                      200 * trackFoodProvider.foodAvailable.length.toDouble(),
                  child: ListView.builder(
                    itemCount: trackFoodProvider.foodAvailable.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<dynamic>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(trackFoodProvider.foodAvailable[index]
                                ["donatorId"])
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(
                              color: lightGreenColor,
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              !snapshot.data!.exists) {
                            return const CircularProgressIndicator(
                              color: lightGreenColor,
                            );
                          } else {
                            var donatorData = snapshot.data!.data();

                            return TrackFoodShowcaseComponent(
                              images: trackFoodProvider.foodAvailable[index]
                                  ["images"],
                              donatorNumber: donatorData["phonenumber"],
                              id: trackFoodProvider.foodAvailable[index]["id"],
                              foodName: trackFoodProvider.foodAvailable[index]
                                  ["name"],
                              foodQuantity: trackFoodProvider
                                  .foodAvailable[index]["quantity"],
                              location: LatLng(
                                trackFoodProvider.foodAvailable[index]
                                    ["location"][0],
                                trackFoodProvider.foodAvailable[index]
                                    ["location"][1],
                              ),
                              donatorId: trackFoodProvider.foodAvailable[index]
                                  ["donatorId"],
                              donatorName: donatorData["username"],
                              date: trackFoodProvider.foodAvailable[index]
                                  ["date"],
                              time: trackFoodProvider.foodAvailable[index]
                                  ["time"],
                              donatorPoints: donatorData["points"],
                            );
                          }
                        },
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
