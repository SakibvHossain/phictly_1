import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/components/custom_text_field.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/core/validation/date_validation.dart';
import 'package:phictly/core/validation/email_validation.dart';
import 'package:get/get.dart';
import 'package:phictly/core/validation/name_validator.dart';
import 'package:phictly/core/validation/phone_validation.dart';
import 'package:phictly/feature/auth/data/controller/sign_up_controller.dart';
import '../../../../core/utils/image_path.dart';
import '../../../../core/validation/password_validation.dart';
import '../../../book/data/controller/date_controller.dart';
import '../../../home/data/controller/bottom_nav_controller.dart';
import '../../../profile/data/controller/change_profile_controller.dart';
import '../widget/dropdown_gender.dart';
import '../widget/dropdown_location.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController controller = Get.put(SignUpController());
  final DateController dateController = Get.put(DateController());
  final ChangeProfileController changeProfileController = Get.put(ChangeProfileController());
  final navController = Get.find<BottomNavController>();
  final List<String> genderList = ["Male", "Female", "Nonbinary"];
  final List<String> locationList = ["United States", "Canada", "Jamaica", "Dominican Republic", "Mexico", "Brazil", "Argentina", "Chile", "Colombia", "Peru", "Bolivia", "United Kingdom", "Germany", "France", "Spain", "Italy", "Netherlands", "Sweden", "Poland", "China", "India", "Japan", "South Korea" , "Indonesia" , "Thailand" , "Philippines" , "Australia" , "New Zealand" , "South Africa" , "Nigeria" , "Kenya" , "Egypt" , "United Arab Emirates" , "Saudi Arabia" , "Turkey" , "Israel"];

  @override
  Widget build(BuildContext context) {
    final signInKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
        ),
        child: Column(
          children: [
            SafeArea(
                child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            )),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Image.asset(Images.splashScreen,
                  width: 238.11.w, height: 78.04.h),
            ),
            SizedBox(
              height: 80.h,
            ),
            Expanded(
              child: Container(
                // width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffEEF0F8),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.r),
                    topLeft: Radius.circular(25.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Form(
                      key: signInKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: CustomText(
                                text: "Sign Up",
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: CustomText(
                              text: "Please fill the fields below",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withValues(alpha: 0.6),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),

                          //* Email
                          CustomTextField(
                            controller: controller.emailController,
                            validator: validateEmail,
                            hintText: "email",
                            prefixIcon: Icons.email,
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          //* Username
                          CustomTextField(
                            controller: controller.usernameController,
                            validator: validateName,
                            hintText: "username",
                            prefixIcon: Icons.person,
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          //* Password
                          Obx(() {
                            return CustomTextField(
                              controller: controller.passwordController,
                              hintText: "password",
                              validator: validatePassword,
                              prefixIcon: Icons.lock,
                              suffixIcon: controller.isEyeOpen.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              suffixIconAction: controller.updateEye,
                              isObscure: !controller
                                  .isEyeOpen.value, // FIXED: Toggle correctly
                            );
                          }),

                          SizedBox(
                            height: 16.h,
                          ),

                          //*
                          CustomTextField(
                            controller: controller.phoneController,
                            validator: phoneValidation,
                            hintText: "phone",
                            inputType: TextInputType.number,
                            prefixIcon: Icons.phone,
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          Obx((){
                            return CustomTextField(
                              isReadOnlyTrue: true,
                              onTap: () {
                                dateController.pickDate(context);

                                debugPrint("+++++++++++++++++++++++${dateController.selectedDate.value}");
                              },
                              // validator: dateValidation,
                              hintText: dateController.selectedDate.value.isEmpty
                                  ? "Select Date"
                                  : dateController.selectedDate.value,
                              prefixIcon: Icons.calendar_month,
                              inputType: TextInputType.datetime,
                            );
                          }),

                          SizedBox(
                            height: 16.h,
                          ),

                          DropdownLocation(
                            locationList: locationList,
                            selectedHint: "Location",
                            icon: Icons.location_on,
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          GenderDropdown(
                            genderList: genderList,
                            selectedHint: "Gender",
                            icon: Icons.mood,
                          ),

                          SizedBox(
                            height: 40.h,
                          ),

                          Obx(
                            () => controller.isLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                : CustomButton(
                                    text: "Sign up",
                                    onTap: () {
                                      if (signInKey.currentState!.validate()) {
                                        controller.signUp(context);
                                      }
                                    },
                                    borderRadius: 8.r,
                                  ),
                          ),

                          SizedBox(
                            height: 45.h,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomText(
                                text: "Version 1.0.0",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
