import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  ValueNotifier<double> progressNotifier = ValueNotifier<double>(20.0);
}