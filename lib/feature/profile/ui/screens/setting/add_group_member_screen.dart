import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:phictly/core/components/custom_text.dart';
import '../../../../../core/components/custom_button.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../create_club/data/controller/change_club_controller.dart';
import '../../../data/controller/change_profile_controller.dart';

class AddGroupMemberScreen extends StatelessWidget {
  AddGroupMemberScreen({super.key});

  final ChangeProfileController controller = Get.put(ChangeProfileController());
  final ChangeClubController changeClubController = Get.put(ChangeClubController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* App bar
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xff29605E)),
              child: Column(
                children: [
                  SizedBox(
                    height: 75.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/icons/home_logo.png",
                          height: 42.93.h,
                          width: 130.96.w,
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 24.h,
            ),

            //* Back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.updateIndex(14);
                    },
                    child: Image.asset(
                      "assets/profile/icons/back_arrow.png",
                      height: 25.h,
                      width: 13.75.w,
                    ),
                  ),
                  SizedBox(
                    width: width / 3.5,
                  ),
                  CustomText(
                    text: "Add Members",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 32.h,
            ),

            //* TextFormField container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Column(
                children: [

                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return ListTile(

                          leading: Image.asset("assets/profile/image/add_member_1.png", height: 50.h, width: 50.w,),
                          title: CustomText(text: "hilamsam19", fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color(0xff000000),),
                          trailing: Obx(() {
                            return GestureDetector(
                              onTap: (){
                                changeClubController.updatePrivateField();
                              },
                              child: Container(
                                width: 23.w,
                                height: 23.h,
                                padding: EdgeInsets.all(2.r),
                                decoration: BoxDecoration(
                                    border: const GradientBoxBorder(
                                      gradient: AppColors.primaryGradientColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(3.68),
                                    shape: BoxShape.rectangle),
                                child: changeClubController.isPrivate.value
                                    ? Image.asset("assets/icons/check.png")
                                    : SizedBox(),
                              ),
                            );
                          }),

                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        );
                      }, itemCount: 5,),

                  SizedBox(height: 16,),

                  CustomButton(text: "Add", borderRadius: 6.r,)
                ],
              ),
            )
            //* You Text Form Fields
          ],
        ),
      ),
    );
  }

  //* Stack based Widget for TextFormField
  Widget textFormFields(
      TextEditingController controller,
      String fieldName,
      int maxLine,
      String imagePath,
      AlignmentGeometry alignGeometry,
      EdgeInsetsGeometry padding,
      EdgeInsetsGeometry contentPadding) {
    return Column(
      children: [
        Stack(
          children: [
            CustomTextField(
              hintText: "additional information",
              maxLine: maxLine,
              borderSide: BorderSide(
                color: Color(0xff000000).withOpacity(0.20),
              ),
              controller: controller,
              hintStyle: GoogleFonts.dmSans(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color(0xff000000).withValues(alpha: 0.50),
              ),
              cursorColor: AppColors.primaryColor,
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Image.asset(
                imagePath,
                width: 20.w,
                height: 25.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
