import 'package:flutter/material.dart';

import '../../../../core/components/custom_outline_button.dart';

class ProfileActionsSection extends StatelessWidget {
  const ProfileActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomOutlineButton(
            text: "Share Profile",
            width: 120,
            height: 40,
            textFontSize: 15,
            borderRadius: 6,
            textFontWeight: FontWeight.w400,
            color: Color(0xff29605E),
          ),
        ],
      ),
    );
  }
}