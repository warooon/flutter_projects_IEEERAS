// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:timelines/timelines.dart";

class RankBadge extends StatelessWidget {
  String imageUrl;
  String rank;
  bool start;
  bool end;
  RankBadge(
      {super.key,
      required this.imageUrl,
      required this.rank,
      required this.start,
      required this.end});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      nodeAlign: TimelineNodeAlign.basic,
      oppositeContents: Padding(
        padding: const EdgeInsets.all(20),
        child: Image(
          width: 50,
          image: NetworkImage(imageUrl),
        ),
      ),
      contents: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          rank,
          style: const TextStyle(
            color: Color.fromRGBO(254, 254, 254, 1),
            fontFamily: "PoppinsSemiBold",
            fontSize: 16,
          ),
        ),
      ),
      node: TimelineNode(
        indicator: const DotIndicator(
          color: Color.fromRGBO(164, 198, 148, 1),
        ),
        startConnector: start == false
            ? const SolidLineConnector(
                color: Color.fromRGBO(164, 198, 148, 1),
              )
            : null,
        endConnector: end == false
            ? const SolidLineConnector(color: Color.fromRGBO(164, 198, 148, 1))
            : null,
      ),
    );
  }
}
