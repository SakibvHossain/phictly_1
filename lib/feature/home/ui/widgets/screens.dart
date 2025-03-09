import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phictly/core/utils/size_config.dart';
import 'package:phictly/feature/book/ui/screens/change_book_screen.dart';
import 'package:phictly/feature/create_club/ui/screens/change_club_screen.dart';
import 'package:phictly/feature/home/ui/screens/change_home_screen.dart';
import 'package:phictly/feature/profile/ui/screens/change_profile_screens.dart';
import 'package:phictly/feature/tv/ui/screen/change_tv_screens.dart';


double animatedPositionedLeftValue(int currentIndex) {
  double totalWidth = AppSizes.screenWidth - (AppSizes.blockSizeHorizontal * 5); // Adjusting for padding
  double buttonWidth = totalWidth / 5; // 5 buttons in total
  return (currentIndex * buttonWidth) + (buttonWidth / 1.8) - (AppSizes.blockSizeHorizontal * 5); // Centering the indicator
}


List<Widget> screens = [
  ChangeHomeScreen(),
  ChangeBookScreen(),
  ChangeClubScreen(),
  ChangeTvScreens(),
  ChangeProfileScreens(),
];



