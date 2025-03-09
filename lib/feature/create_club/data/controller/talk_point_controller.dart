import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/create_club/data/model/add_talk_points.dart';

class TalkPointController extends GetxController {
  //* Club Label
  final TextEditingController clubLabelController = TextEditingController();

  var selectedDate = DateTime.now().obs;
  var talkPoints = <int>[].obs;
  var randomNumber = 50588791;
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


  //* Reduced Collisions
  void generateLargeNumber() {
    Random secure = Random.secure();
    Uint8List bytes =
    Uint8List(4); //* 4 bytes = 32 bits (can hold a large enough number)

    for (int i = 0; i < bytes.length; i++) {
      bytes[i] = secure.nextInt(256); //* Filling bytes with random values
    }

    randomNumber = bytes.buffer.asByteData().getUint32(0) % 90000000 + 10000000;
  }
}