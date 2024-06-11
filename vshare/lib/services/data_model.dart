import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  String _username = 'Username';
  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  int _points = 0;
  int _ptsToNextRank = 0;
  String _rank = "Iron";
  String _nextRank = "Bronze";
  String _rankImage =
      "https://imgs.search.brave.com/r806OfQ5XRbq0DhM6YINAwP4X9-pvdPd-_FP5BfmJ_I/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy8xODU0LXZh/bG9yYW50LWlyb24t/My5wbmc";
  String _nextRankImage =
      "https://imgs.search.brave.com/bcRT6QR5B9e6PULuImVzibW5eSuTZj5PBE0xz5Qko3c/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy80NTkwLXZh/bG9yYW50LWJyb256/ZS0zLnBuZw";
  String _pfpImage =
      "https://imgs.search.brave.com/jQ9T_wjltnrmqjNnbwuSmoh5N2cz8AAXJCbUXUN6pac/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9uZnQt/bW9ua2V5LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMy8w/My85M2YxMTQyNjlk/NWM4YTZkYWNiY2Y1/ODdlNGI0YzQ5My0x/LnBuZw";

  Color _color = const Color.fromRGBO(74, 76, 75, 1);

  String get username => _username;
  String get uid => _uid;
  String get rank => _rank;
  String get nextRank => _nextRank;
  String get rankImage => _rankImage;
  String get nextRankImage => _nextRankImage;
  String get pfpImage => _pfpImage;
  int get ptsToNextRank => _ptsToNextRank;

  Color get color => _color;

  int get points => _points;

  Map<String, List<dynamic>> rankAndImage = {
    "Iron": [
      "https://imgs.search.brave.com/r806OfQ5XRbq0DhM6YINAwP4X9-pvdPd-_FP5BfmJ_I/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy8xODU0LXZh/bG9yYW50LWlyb24t/My5wbmc",
      const Color.fromRGBO(74, 76, 75, 1),
      "https://imgs.search.brave.com/jQ9T_wjltnrmqjNnbwuSmoh5N2cz8AAXJCbUXUN6pac/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9uZnQt/bW9ua2V5LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMy8w/My85M2YxMTQyNjlk/NWM4YTZkYWNiY2Y1/ODdlNGI0YzQ5My0x/LnBuZw"
    ],
    "Bronze": [
      "https://imgs.search.brave.com/bcRT6QR5B9e6PULuImVzibW5eSuTZj5PBE0xz5Qko3c/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy80NTkwLXZh/bG9yYW50LWJyb256/ZS0zLnBuZw",
      const Color.fromRGBO(119, 98, 60, 1),
      "https://imgs.search.brave.com/o0ICtRhZSKkvkx1wJQm7UQ_99ma7mmtrYbE1CfMHnlo/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzBhL2Nj/LzJkLzBhY2MyZDhj/MDA2NGNiNjkyNmEz/MmM3YjE3ZDIxMDk1/LmpwZw"
    ],
    "Gold": [
      "https://imgs.search.brave.com/uFYEvI0CBZlyQekacWu-J5tAJNVrZGwVaOtxQ7kAFCg/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy8yMDYwLXZh/bG9yYW50LWdvbGQt/Mi5wbmc",
      const Color.fromRGBO(169, 140, 82, 1),
      "https://imgs.search.brave.com/lPd9lHjfVpKOxmpe8hhSsYeXcBeTopYeREsAPb7j7Dg/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9uZnQt/bW9ua2V5LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMy8w/My9MYXllci0yLTEt/MS5wbmc"
    ],
    "Silver": [
      "https://imgs.search.brave.com/OI94hDmD_EGRO8lhVYErlZTNcPNj5Aeg2emK-_RzmB8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy8zMjkzLXZh/bG9yYW50LXNpbHZl/ci0zLnBuZw",
      const Color.fromRGBO(194, 200, 199, 1),
      "https://imgs.search.brave.com/ahLyAgmCoh5TxcV_CxILPJKj7q-yqCNZp-r5g_UOGAY/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9uZnQt/bW9ua2V5LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMy8w/My9hNzZhYWIyNDFj/MWE4OWE4NTNmNDA3/Y2NlZTczMGE4Zi0x/LTEwMjR4MTAyNC5w/bmc"
    ],
    "Platinum": [
      "https://imgs.search.brave.com/OstL2AU4hlE4k0t1gNRW4rETgKC0nBdwvuaSTbRirAA/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4z/LmVtb2ppLmdnL2Vt/b2ppcy8zMjU1LXZh/bG9yYW50LXBsYXRp/bnVtLTIucG5n",
      const Color.fromRGBO(44, 109, 121, 1),
      "https://imgs.search.brave.com/N91rB_d9U7WPwScFCA5KWTKVqJYPk7igr2tNOkIHqZ4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9uZnQt/bW9ua2V5LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMy8w/My8xNzIyN2Q5OGEx/YTk5YjVmYTIzMDUz/NGQyNDZkMTlhOC0x/LnBuZw"
    ],
    "Diamond": [
      "https://imgs.search.brave.com/2sME6-PbG-AwNaaole7Ccwc9UHTwmiEYr6HeT4VPTFI/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/bWV0YXNyYy5jb20v/YXNzZXRzL2ltYWdl/cy92YWxvcmFudC9y/YW5rcy9kaWFtb25k/LnBuZw",
      const Color.fromRGBO(160, 127, 161, 1),
      "https://imgs.search.brave.com/VLu-KwrK0troRiyGi6YFeeoMVNVdhMJO3eu1vdOX7Ew/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9uZnQt/bW9ua2V5LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMy8w/My8yLTEucG5n"
    ]
  };

  void updateDataModel(String username, int points) {
    _username = username;
    _points = points;

    if (_points >= 0 && _points <= 10) {
      _rank = "Iron";
      _nextRank = "Bronze";
      _ptsToNextRank = _points - 10;
    } else if (_points >= 11 && _points <= 20) {
      _rank = "Bronze";
      _nextRank = "Silver";
      _ptsToNextRank = _points - 20;
    } else if (_points >= 21 && _points <= 30) {
      _rank = "Silver";
      _nextRank = "Gold";
      _ptsToNextRank = _points - 30;
    } else if (_points >= 31 && _points <= 40) {
      _rank = "Gold";
      _nextRank = "Platinum";
      _ptsToNextRank = _points - 40;
    } else if (_points >= 41 && _points <= 50) {
      _rank = "Platinum";
      _nextRank = "Diamond";
      _ptsToNextRank = _points - 50;
    } else if (_points >= 51 && _points <= 60) {
      _rank = "Diamond";
      _nextRank = "none";
    }

    _rankImage = rankAndImage[_rank]![0]!;
    _color = rankAndImage[_rank]![1];
    _pfpImage = rankAndImage[_rank]![2];
    if (nextRank == "none") {
      _nextRankImage = "";
    } else {
      _nextRankImage = rankAndImage[_nextRank]![0];
    }
    notifyListeners();
  }
}
