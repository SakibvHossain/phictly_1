import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_outline_button.dart';
import '../../data/controller/change_profile_controller.dart';

class ProfileBadgesSection extends StatelessWidget {
  const ProfileBadgesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangeProfileController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          CustomOutlineButton(
            onTap: () => controller.updateIndex(2),
            text: "Badges",
            height: 28,
            width: 80,
            borderRadius: 4,
            textFontSize: 14,
            textFontWeight: FontWeight.w400,
          ),
          SizedBox(width: 8),
          CustomOutlineButton(
            onTap: () => controller.updateIndex(13),
            text: "My Log",
            height: 28,
            width: 80,
            borderRadius: 4,
            textFontSize: 14,
            textFontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}