import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vshare/services/data_model.dart";
import "package:vshare/services/food_available_modal.dart";
import "package:vshare/services/previous_donate_modal.dart";
import "package:vshare/services/track_beneficiary_modal.dart";
import "package:vshare/services/track_food_modal.dart";

class FirebaseUpdation {
  static void listenToStreamForProfilePage(BuildContext context) {
    final dataProvider = Provider.of<DataModel>(context, listen: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        final username = snapshot.get("username");
        final points = snapshot.get("points");

        dataProvider.updateDataModel(username, points);
      }
    });
  }

  static void listenToPreviousDonations(BuildContext context) {
    var previousDonationProvider =
        Provider.of<PreviousDonateModal>(context, listen: false);

    FirebaseFirestore.instance
        .collection("donations")
        .where("donatorId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List previousDonationsData = [];

      for (var doc in snapshot.docs) {
        previousDonationsData.add(doc.data()!);
      }

      previousDonationProvider.updatePreviousDonations(previousDonationsData);
    });
  }

  static void listenToFoodAvailable(BuildContext context) {
    var foodAvailableProvider =
        Provider.of<FoodAvailableModal>(context, listen: false);

    FirebaseFirestore.instance
        .collection("donations")
        .where("receiverName", isEqualTo: "")
        .where("donatorId",
            isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List foodAvailableData = [];
      for (var doc in snapshot.docs) {
        foodAvailableData.add(doc.data());
      }
      foodAvailableProvider.updateFoodAvailable(foodAvailableData);
    });
  }

  static void listenToFoodsToTrack(BuildContext context) {
    var foodAvailableProvider =
        Provider.of<TrackFoodModal>(context, listen: false);

    FirebaseFirestore.instance
        .collection("donations")
        .where("bookedby", isEqualTo: "booked")
        .where("receiverId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List foodAvailableData = [];
      for (var doc in snapshot.docs) {
        foodAvailableData.add(doc.data());
      }
      foodAvailableProvider.updateFoodAvailable(foodAvailableData);
    });
  }

  static void listenToBeneficiary(BuildContext context) {
    var foodAvailableProvider =
        Provider.of<TrackBeneficiaryModal>(context, listen: false);

    FirebaseFirestore.instance
        .collection("donations")
        .where("bookedby", isEqualTo: "booked")
        .where("donatorId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List foodAvailableData = [];
      for (var doc in snapshot.docs) {
        foodAvailableData.add(doc.data());
      }
      foodAvailableProvider.updateFoodAvailable(foodAvailableData);
    });
  }
}
