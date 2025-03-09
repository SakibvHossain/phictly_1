import 'package:get/get.dart';

class HomeController extends GetxController{
  var timeLine = 1.0.obs;
  var recentTimeLine = 1.0.obs;
  var memberCount = 30.0.obs;

  void changeTimeLine(double value) {
    timeLine.value = value;
  }

  void changeRecentTimeLine(double value) {
    recentTimeLine.value = value;
  }

  void changeTotalPersonCount(double value) {
    memberCount.value = value;
  }
}