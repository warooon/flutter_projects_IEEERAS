// ignore_for_file: must_be_immutable

import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:photo_view/photo_view.dart";

class FoodImageViewerPage extends StatelessWidget {
  List images;
  FoodImageViewerPage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: CarouselSlider(
        options: CarouselOptions(
            height: double.infinity, enableInfiniteScroll: false),
        items: images.map((i) {
          return Builder(
            builder: (BuildContext context) {
              print(images);

              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: PhotoView(
                    imageProvider: NetworkImage(i),
                  ));
            },
          );
        }).toList(),
      ),
    );
  }
}
