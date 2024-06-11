// ignore_for_file: must_be_immutable, use_build_context_synchronously

import "package:cloud_firestore/cloud_firestore.dart";
import "package:dotted_border/dotted_border.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:provider/provider.dart";
import "package:uuid/uuid.dart";
import "package:vshare/components/snackbar_component.dart";
import "package:vshare/components/textfield_component_2.dart";
import "package:vshare/pages/location_picker_page.dart";
import "package:vshare/resources/Colors.dart";
import "package:vshare/resources/image_selector.dart";
import "package:vshare/services/food_donate_modal.dart";
import "package:vshare/services/storage_methods.dart";

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  StorageMethods storageMethods = StorageMethods();
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodQuantityController = TextEditingController();
  final TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  bool donating = false;

  @override
  Widget build(BuildContext context) {
    final foodDonateModal = Provider.of<FoodDonateModal>(context, listen: true);

    void resetFoodDonateModal() {
      foodDonateModal.setFoodName("");
      foodDonateModal.setFoodQuantity("");
      foodDonateModal.setLocation(null);
      foodDonateModal.setTime(const TimeOfDay(hour: 7, minute: 15));
      foodDonateModal.setImages([]);
    }

    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.transparent));
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          (foodDonateModal.foodname != "" ||
                  foodDonateModal.foodquantity != "" ||
                  foodDonateModal.location != null ||
                  foodDonateModal.time !=
                      const TimeOfDay(hour: 7, minute: 15) ||
                  foodDonateModal.images.isNotEmpty)
              ? IconButton(
                  onPressed: () {
                    resetFoodDonateModal();
                  },
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                  ))
              : Container(),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            foodDonateModal.setFoodName(foodNameController.text);
            foodDonateModal.setFoodQuantity(foodQuantityController.text);
            foodDonateModal.setTime(_time);

            Navigator.pop(context);
          },
        ),
        backgroundColor: lightGreenColor,
      ),
      backgroundColor: lightGreenColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            donating == true
                ? const LinearProgressIndicator(
                    minHeight: 2,
                    color: lightGreenColor,
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Donate",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "What food is it?",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 15),
                  ),
                  TextFieldComponent2(
                      hintText: "e.g. idly", controller: foodNameController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Quantity",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 15),
                  ),
                  TextFieldComponent2(
                    controller: foodQuantityController,
                    hintText: "e.g. 5kg",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Food location",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      readOnly: true,
                      cursorColor: greyColor,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "PoppinsRegular",
                          fontSize: 15),
                      decoration: InputDecoration(
                        hintText: foodDonateModal.location == null
                            ? "Pick Location"
                            : "${foodDonateModal.location!.latitude}, ${foodDonateModal.location!.longitude} ",
                        contentPadding: const EdgeInsets.all(15),
                        hintStyle: const TextStyle(
                            color: greyColor,
                            fontFamily: "PoppinsRegular",
                            fontSize: 15),
                        fillColor: const Color.fromRGBO(52, 90, 65, 1),
                        filled: true,
                        prefixIcon: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LocationPickerPage()));
                          },
                          child: const Icon(
                            Icons.location_on,
                            color: greyColor,
                          ),
                        ),
                        focusedBorder: border,
                        enabledBorder: border,
                        disabledBorder: border,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Pickup Time",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      readOnly: true,
                      cursorColor: greyColor,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "PoppinsRegular",
                          fontSize: 15),
                      decoration: InputDecoration(
                        hintText: foodDonateModal.time.format(context),
                        contentPadding: const EdgeInsets.all(15),
                        hintStyle: const TextStyle(
                            color: greyColor,
                            fontFamily: "PoppinsRegular",
                            fontSize: 15),
                        fillColor: const Color.fromRGBO(52, 90, 65, 1),
                        filled: true,
                        prefixIcon: GestureDetector(
                          onTap: () async {
                            final TimeOfDay? newTime = await showTimePicker(
                                context: context, initialTime: _time);

                            if (newTime != null) {
                              foodDonateModal
                                  .setFoodName(foodNameController.text);
                              foodDonateModal
                                  .setFoodQuantity(foodQuantityController.text);
                              foodDonateModal.setTime(newTime);
                            }
                          },
                          child: const Icon(
                            Icons.av_timer_rounded,
                            color: greyColor,
                          ),
                        ),
                        focusedBorder: border,
                        enabledBorder: border,
                        disabledBorder: border,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add images",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 15),
                      ),
                      foodDonateModal.images.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        backgroundColor: Colors.transparent,
                                        title: const Text(
                                          "Choose one",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "PoppinsSemibold",
                                              fontSize: 25),
                                        ),
                                        children: [
                                          SimpleDialogOption(
                                            child: GestureDetector(
                                              onTap: () async {
                                                var image = await pickImage(
                                                    ImageSource.camera);

                                                if (image != null) {
                                                  var images =
                                                      foodDonateModal.images;
                                                  images.add(image);
                                                  foodDonateModal
                                                      .setImages(images);
                                                  print(images);
                                                }
                                              },
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Open Camera",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            "PoppinsSemibold",
                                                        fontSize: 15),
                                                  ),
                                                  Icon(
                                                    Icons.add_a_photo_rounded,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              var image = await pickImage(
                                                  ImageSource.gallery);
                                              if (image != null) {
                                                var images =
                                                    foodDonateModal.images;
                                                images.add(image);
                                                foodDonateModal
                                                    .setImages(images);
                                                print(images);
                                              }
                                            },
                                            child: const SimpleDialogOption(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Open Gallery",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            "PoppinsSemibold",
                                                        fontSize: 15),
                                                  ),
                                                  Icon(
                                                    Icons.photo,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: const Icon(
                                Icons.add_a_photo_sharp,
                                color: Colors.white,
                                size: 18,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                        dashPattern: const [10, 10],
                        color: Colors.grey,
                        strokeWidth: 2,
                        child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(52, 90, 65, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: foodDonateModal.images.isEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SimpleDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              title: const Text(
                                                "Choose one",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        "PoppinsSemibold",
                                                    fontSize: 25),
                                              ),
                                              children: [
                                                SimpleDialogOption(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      var image =
                                                          await pickImage(
                                                              ImageSource
                                                                  .camera);

                                                      if (image != null) {
                                                        var images =
                                                            foodDonateModal
                                                                .images;
                                                        images.add(image);
                                                        foodDonateModal
                                                            .setImages(images);
                                                      }
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Open Camera",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "PoppinsSemibold",
                                                              fontSize: 15),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .add_a_photo_rounded,
                                                          color: Colors.white,
                                                          size: 18,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    var image = await pickImage(
                                                        ImageSource.gallery);
                                                    if (image != null) {
                                                      var images =
                                                          foodDonateModal
                                                              .images;
                                                      images.add(image);
                                                      foodDonateModal
                                                          .setImages(images);
                                                    }
                                                  },
                                                  child:
                                                      const SimpleDialogOption(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Open Gallery",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "PoppinsSemibold",
                                                              fontSize: 15),
                                                        ),
                                                        Icon(
                                                          Icons.photo,
                                                          color: Colors.white,
                                                          size: 18,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      Icons.add_a_photo_rounded,
                                      color: greyColor,
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: foodDonateModal.images.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        fit: StackFit.passthrough,
                                        children: [
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              child: Image(
                                                image: MemoryImage(
                                                    foodDonateModal
                                                        .images[index]),
                                              )),
                                          Positioned(
                                            top: -15,
                                            right: -15,
                                            child: IconButton(
                                                onPressed: () {
                                                  foodDonateModal.images.remove(
                                                      foodDonateModal
                                                          .images[index]);

                                                  var images =
                                                      foodDonateModal.images;

                                                  foodDonateModal
                                                      .setImages(images);
                                                },
                                                icon: const Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.red,
                                                  size: 18,
                                                )),
                                          )
                                        ],
                                      );
                                    })),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () async {
                        if (foodNameController.text.isEmpty ||
                            foodQuantityController.text.isEmpty ||
                            foodDonateModal.location == null ||
                            foodDonateModal.images.isEmpty) {
                          SnackBarComponent.showSnackBar(context, "warning",
                              "Please fill out all fields.");
                        } else {
                          try {
                            setState(() {
                              donating = true;
                            });
                            String foodName = foodNameController.text;
                            String foodQuantity = foodQuantityController.text;

                            var listOfImageURLs = [];

                            for (var i = 0;
                                i < foodDonateModal.images.length;
                                i++) {
                              listOfImageURLs.add(
                                  await storageMethods.uploadImageToStorage(
                                      "images",
                                      foodDonateModal.images[i],
                                      false));
                            }

                            print(listOfImageURLs);

                            var donationId = const Uuid().v1();
                            DateTime now = DateTime.now();
                            String formattedDate =
                                '${now.year}-${now.month}-${now.day}';

                            await FirebaseFirestore.instance
                                .collection("donations")
                                .doc(donationId)
                                .set({
                              "id": donationId,
                              "name": foodName,
                              "quantity": foodQuantity,
                              "location": [
                                foodDonateModal.location!.latitude,
                                foodDonateModal.location!.longitude
                              ],
                              "time": foodDonateModal.time.format(context),
                              "date": formattedDate,
                              "images": listOfImageURLs,
                              "donatorId":
                                  FirebaseAuth.instance.currentUser!.uid,
                              "receiverId": "",
                              "receiverName": "",
                              "bookedby": ""
                            });

                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              "donations": FieldValue.arrayUnion([donationId]),
                            });
                            resetFoodDonateModal();
                            Navigator.pop(context);
                          } catch (e) {
                          } finally {
                            setState(() {
                              donating = false;
                            });
                          }
                        }
                      },
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(52, 90, 65, 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Donate",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "PoppinsSemiBold",
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image(
                              width: 30,
                              image: NetworkImage(
                                  "https://cdn-icons-png.flaticon.com/128/11008/11008379.png"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
