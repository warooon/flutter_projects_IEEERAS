import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vshare/components/rank_badge.dart";
import "package:vshare/resources/Colors.dart";
import "package:vshare/services/auth_service.dart";
import "package:vshare/services/data_model.dart";
import "package:vshare/services/firebase_updation.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool rankDropDown = false;

  @override
  void initState() {
    super.initState();
    FirebaseUpdation.listenToStreamForProfilePage(context);
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataModel>(context, listen: true);
    final authProvider = Provider.of<AuthService>(context, listen: false);

    return SafeArea(
        child: Scaffold(
      backgroundColor: lightGreenColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    minRadius: 45,
                    maxRadius: 45,
                    backgroundImage: NetworkImage(dataProvider.pfpImage),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataProvider.username,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(133, 151, 113, 1)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 10),
                              child: Text(
                                "${dataProvider.points}  ⭐️",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "PoppinsSemiBold",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              authProvider.logout();
                            },
                            child: const Text(
                              "Log out",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "PoppinsSemiBold",
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Current Rank: ",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        dataProvider.rank,
                        style: TextStyle(
                            color: dataProvider.color,
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 16),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Image(
                          width: 50,
                          image: NetworkImage(dataProvider.rankImage)),
                      const SizedBox(
                        width: 15,
                      ),
                      rankDropDown == false
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  rankDropDown = !rankDropDown;
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
                                  rankDropDown = !rankDropDown;
                                });
                              },
                              child: const Icon(
                                Icons.arrow_drop_up,
                                color: Colors.white,
                              ),
                            )
                    ],
                  ),
                  rankDropDown == true
                      ? Column(
                          children: [
                            RankBadge(
                              start: true,
                              end: false,
                              imageUrl:
                                  "https://imgs.search.brave.com/r806OfQ5XRbq0DhM6YINAwP4X9-pvdPd-_FP5BfmJ_I/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy8xODU0LXZh/bG9yYW50LWlyb24t/My5wbmc",
                              rank: "Iron",
                            ),
                            RankBadge(
                              start: false,
                              end: false,
                              imageUrl:
                                  "https://imgs.search.brave.com/bcRT6QR5B9e6PULuImVzibW5eSuTZj5PBE0xz5Qko3c/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy80NTkwLXZh/bG9yYW50LWJyb256/ZS0zLnBuZw",
                              rank: "Bronze",
                            ),
                            RankBadge(
                              start: false,
                              end: false,
                              imageUrl:
                                  "https://imgs.search.brave.com/uFYEvI0CBZlyQekacWu-J5tAJNVrZGwVaOtxQ7kAFCg/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy8yMDYwLXZh/bG9yYW50LWdvbGQt/Mi5wbmc",
                              rank: "Gold",
                            ),
                            RankBadge(
                              start: false,
                              end: false,
                              imageUrl:
                                  "https://imgs.search.brave.com/OI94hDmD_EGRO8lhVYErlZTNcPNj5Aeg2emK-_RzmB8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy8zMjkzLXZh/bG9yYW50LXNpbHZl/ci0zLnBuZw",
                              rank: "Silver",
                            ),
                            RankBadge(
                                start: false,
                                end: false,
                                imageUrl:
                                    "https://imgs.search.brave.com/OstL2AU4hlE4k0t1gNRW4rETgKC0nBdwvuaSTbRirAA/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy8zMjU1LXZh/bG9yYW50LXBsYXRp/bnVtLTIucG5n",
                                rank: "Platinum"),
                            RankBadge(
                              start: false,
                              end: true,
                              imageUrl:
                                  "https://imgs.search.brave.com/2sME6-PbG-AwNaaole7Ccwc9UHTwmiEYr6HeT4VPTFI/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/bWV0YXNyYy5jb20v/YXNzZXRzL2ltYWdl/cy92YWxvcmFudC9y/YW5rcy9kaWFtb25k/LnBuZw",
                              rank: "Diamond",
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  dataProvider.rank != "Diamond"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${dataProvider.ptsToNextRank.abs()} donations more to ",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "PoppinsSemiBold",
                                  fontSize: 16),
                            ),
                            Image(
                                width: 50,
                                image: NetworkImage(dataProvider.nextRankImage))
                          ],
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
