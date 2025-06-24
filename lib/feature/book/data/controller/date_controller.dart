import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';


class DateController extends GetxController {
  var selectedDate = "".obs;
  DateTime selectedDateTime = DateTime.now();

  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1921),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            hintColor: Colors.blue,
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = DateFormat("MM-dd-yyyy").format(picked);
      selectedDateTime = picked;
    }
  }


  bool isSelectedDateValid(String selectedDateStr, String type) {
    DateTime now = DateTime.now();
    DateTime? selectedDate;

    try {
      selectedDate = DateFormat("MM-dd-yyyy").parse(selectedDateStr);
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