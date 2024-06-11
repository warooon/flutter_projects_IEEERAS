// ignore_for_file: must_be_immutable

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class FoodDonationComponent extends StatelessWidget {
  String id;
  String foodName;
  String receiverName;
  FoodDonationComponent(
      {super.key,
      required this.id,
      required this.foodName,
      required this.receiverName});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(foodName),
      background: Container(
        padding: const EdgeInsets.only(right: 50),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete_sharp,
          color: Colors.red,
          size: 25,
        ),
      ),
      onDismissed: (direction) {
        FirebaseFirestore.instance.collection("donations").doc(id).delete();
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "donations": FieldValue.arrayRemove([id]),
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(52, 91, 64, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Food",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsRegular",
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    foodName,
                    style: const TextStyle(
                        color: Color.fromRGBO(164, 198, 148, 1),
                        fontFamily: "PoppinsSemibold",
                        fontSize: 16),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Collected by",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsRegular",
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    receiverName,
                    style: const TextStyle(
                        color: Color.fromRGBO(164, 198, 148, 1),
                        fontFamily: "PoppinsSemibold",
                        fontSize: 16),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
