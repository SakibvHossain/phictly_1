import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phictly/feature/create_club/data/model/add_talk_points.dart';

class TalkPointController extends GetxController {
  //* Club Label
  final TextEditingController clubLabelController = TextEditingController();

  var selectedDate = DateTime.now().obs;
  var talkPoints = <int>[].obs;

  int clubIdNumber = 1;
  String formattedClubId = "";

  var createdClubBook = [];

  void addTalkPoint() {
    int day = selectedDate.value.day;
    if (!talkPoints.contains(day) && day >= 1 && day <= 30) {
      talkPoints.add(day);
    }
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();

    //*Automatically update `editTextEnabled` when `talkPointList` changes
    ever(talkPointRxList, (_) {
      editTextEnabled.value = talkPointRxList.length > 5;
    },);
  }


  var talkPointRxList = <AddTalkPoints>[].obs;
  var editTextEnabled = false.obs;
  var talkPointList = <AddTalkPoints>[];



  void addTalkPointListOnRxList() {
    talkPointRxList.clear();
    talkPointRxList.addAll(talkPointList);
    print("+++++++++++++++++++++++++++++++++++++++${talkPointRxList.length}");
  }

  void updateClubId() {
    clubIdNumber += 1;

    if (clubIdNumber < 1000000) {
      formattedClubId = clubIdNumber.toString();
    } else {
      //* Determine the letter prefix based on million groups
      int millions = clubIdNumber ~/ 1000000; //* 1 for A, 2 for B, 3 for C
      int offset = clubIdNumber % 1000000;

      String letter = String.fromCharCode(64 + millions); //* 65 is 'A', 66 is 'B', ...
      int subId = offset == 0 ? 1 : offset; //* start with A1, not A0

      formattedClubId = "$letter$subId";
    }

    print("Generated Club ID: $formattedClubId");
  }

  bool isSelectedDateValid(String selectedDateStr, String type) {
    DateTime now = DateTime.now();
    DateTime? selectedDate;

    try {
      selectedDate = DateFormat("MM-dd-yyyy").parse(selectedDateStr);
      debugPrint("++++++++++++++++++++AAAAAAAAAAAAAAAAA+++++++++++++++++++++++++$now");
      debugPrint("++++++++++++++++++++AAAAAAAAAAAAAAAAA+++++++++++++++++++++++++$selectedDate");
    } catch (_) {
      return false;
    }

    Duration difference = selectedDate.difference(now);
    int maxDays = 0;
    if (type.contains("Book")) {
      maxDays = 30;
    } else if (type.contains("Show")) {
      maxDays = 270;
    } else if (type.contains("Movie")) {
      maxDays = 7;
    }
    return difference.inDays >= 0 && difference.inDays <= maxDays;
  }

}