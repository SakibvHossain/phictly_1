import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/controller/location_dropdown_controller.dart';

class DropdownLocation extends StatelessWidget {
  DropdownLocation({super.key, required this.locationList, required this.selectedHint, required this.icon});

  final LocationDropdownController controller = Get.put(LocationDropdownController());

  final List<String> locationList;
  final String selectedHint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Adjust width
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Gender Icon
          Icon(
            icon,
            color: Color(0xff29605E),
          ),
          SizedBox(width: 10.w),

          // Dropdown Button with GetX
          Expanded(
            child: Obx(() => DropdownButtonHideUnderline(

              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                value: controller.selectedLocation.value == "Select"
                    ? null
                    : controller.selectedLocation.value,
                hint: Text(
                  selectedHint,
                  style: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withValues(alpha: 0.6)),
                ),
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: locationList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.dmSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withValues(alpha: 0.6)),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.updateLocation(newValue);
                  }
                },
              ),
            )),
          ),
        ],
      ),
    );
  }
}