// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:provider/provider.dart";
import "package:vshare/components/food_donation_component.dart";
import "package:vshare/components/waiting_for_beneficiary_component.dart";
import "package:vshare/pages/donate_page.dart";
import "package:vshare/resources/Colors.dart";
import "package:vshare/services/data_model.dart";
import "package:vshare/services/firebase_updation.dart";
import "package:vshare/services/previous_donate_modal.dart";
import "package:vshare/services/track_beneficiary_modal.dart";

class FoodDonationPage extends StatefulWidget {
  FoodDonationPage({Key? key});
  bool showAllPreviousDonations = false;

  @override
  State<FoodDonationPage> createState() => _FoodDonationPageState();
}

class _FoodDonationPageState extends State<FoodDonationPage> {
  @override
  void initState() {
    super.initState();
    FirebaseUpdation.listenToPreviousDonations(context);
    FirebaseUpdation.listenToStreamForProfilePage(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var dataModelProvider = Provider.of<DataModel>(context, listen: true);
    var previousDonationProvider =
        Provider.of<PreviousDonateModal>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGreenColor,
        body: Column(
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
                          image: AssetImage("assets/images/homepageimage.png"),
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
                          image: AssetImage("assets/images/tray.png"),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                      top: 180,
                      left: 15,
                      child: Text(
                        "Donate it!",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 30),
                      )),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Previous Donations",
                            style: TextStyle(
                                fontFamily: "PoppinsSemiBold",
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.showAllPreviousDonations =
                                    !widget.showAllPreviousDonations;
                              });
                            },
                            child: Text(
                              widget.showAllPreviousDonations == true
                                  ? "Show Less"
                                  : "Show All",
                              style: const TextStyle(
                                  fontFamily: "PoppinsSemiBold",
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      previousDonationProvider.previousDonations.isNotEmpty
                          ? widget.showAllPreviousDonations == true
                              ? SizedBox(
                                  height: previousDonationProvider
                                          .previousDonations.length *
                                      110,
                                  child: ListView.builder(
                                      itemCount: previousDonationProvider
                                          .previousDonations.length,
                                      itemBuilder: (context, index) {
                                        return FoodDonationComponent(
                                          id: previousDonationProvider
                                              .previousDonations[index]["id"],
                                          foodName: previousDonationProvider
                                              .previousDonations[index]["name"],
                                          receiverName: previousDonationProvider
                                                          .previousDonations[
                                                      index]["receiverName"] ==
                                                  ""
                                              ? "Not yet collected"
                                              : previousDonationProvider
                                                      .previousDonations[index]
                                                  ["receiverName"],
                                        );
                                      }))
                              : FoodDonationComponent(
                                  id: previousDonationProvider
                                      .previousDonations[0]["id"],
                                  foodName: previousDonationProvider
                                      .previousDonations[0]["name"],
                                  receiverName: previousDonationProvider
                                                  .previousDonations[0]
                                              ["receiverName"] ==
                                          ""
                                      ? "Not yet collected"
                                      : previousDonationProvider
                                          .previousDonations[0]["receiverName"],
                                )
                          : Container(),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenSize.width * 0.42,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Color.fromRGBO(132, 150, 113, 1),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text("Wohoo",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "PoppinsSemiBold",
                                          color:
                                              Color.fromRGBO(90, 89, 75, 1))),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            65, 119, 95, 1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          "${dataModelProvider.points} points",
                                          style: const TextStyle(
                                              color: yellowColor,
                                              fontFamily: "PoppinsSemiBold",
                                              fontSize: 10),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text("Keep Donating!",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "PoppinsSemiBold",
                                          color:
                                              Color.fromRGBO(14, 60, 42, 1))),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: screenSize.width * 0.42,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Color.fromRGBO(65, 119, 95, 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Share your surplus. Feed someone's soul",
                                      style: TextStyle(
                                          fontFamily: "PoppinsSemiBold",
                                          color: Colors.white,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DonatePage()));
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: const Color.fromRGBO(
                                                164, 198, 148, 1),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 3),
                                            child: Text("Donate Now",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        "PoppinsSemibold",
                                                    fontSize: 13)),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 15,
                      ),
                      const WaitingForBeneficiary(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaitingForBeneficiary extends StatefulWidget {
  const WaitingForBeneficiary({super.key});

  @override
  State<WaitingForBeneficiary> createState() => _WaitingForBeneficiaryState();
}

class _WaitingForBeneficiaryState extends State<WaitingForBeneficiary> {
  bool trackFoodDropDown = true;

  @override
  void initState() {
    super.initState();
    FirebaseUpdation.listenToBeneficiary(context);
  }

  @override
  Widget build(BuildContext context) {
    final trackFoodProvider = Provider.of<TrackBeneficiaryModal>(context);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Waiting for beneficiary",
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

                            return WaitingForBeneficiaryComponent(
                              images: trackFoodProvider.foodAvailable[index]
                                  ["images"],
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
                              receiverId: trackFoodProvider.foodAvailable[index]
                                  ["receiverId"],
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
