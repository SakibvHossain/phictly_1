import 'package:get/get.dart';

class HomeController extends GetxController{
  var timeLine = 1.0.obs;
  var recentTimeLine = 30.0.obs;
  var memberCount = 30.0.obs;

  var talkPoints = <double>[].obs;

  void addTalkPoint(double value) {
    if (!talkPoints.contains(value)) {
      talkPoints.add(value);
    }
  }

  void changeTimeLine(double value) {
    timeLine.value = value;
  }

  void changeRecentTimeLine(double value) {
    recentTimeLine.value = value;
  }

  void changeTotalPersonCount(double value) {
    memberCount.value = value;
  }

  void editTalkPoint(int index, DateTime newDate) {
    final now = DateTime.now();
    final difference = newDate.difference(now).inDays + 1;

    if (difference >= 1 && difference <= recentTimeLine.value) {
      talkPoints[index] = difference.toDouble(); //* Updates dot position
    }
  }
}