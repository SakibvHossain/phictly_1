import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/components/custom_text_field.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/core/validation/email_validation.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/auth/ui/screens/sign_up_screen.dart';
import '../../../../core/utils/image_path.dart';
import '../../../../core/validation/password_validation.dart';
import '../../../home/data/controller/bottom_nav_controller.dart';
import '../../../profile/data/controller/change_profile_controller.dart';
import '../../data/controller/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController controller = Get.put(SignInController());
  final ChangeProfileController changeProfileController = Get.put(ChangeProfileController());
  final navController =  Get.find<BottomNavController>();

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
            SizedBox(
              height: 100.h,
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
                            height: 80.h,
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: CustomText(
                                text: "Welcome Back!",
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: CustomText(
                              text: "Enter your credentials to Sign in",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withValues(alpha: 0.6),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          CustomTextField(
                            controller: controller.emailController,
                            validator: validateEmail,
                            hintText: "email",
                            focusNode: controller.emailFocusNode,
                            nextFocus: controller.passwordFocusNode,
                            prefixIcon: Icons.email,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
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
                            height: 50.h,
                          ),
                          Obx(
                            () => controller.isLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                : CustomButton(
                                    text: "Sign in",
                                    onTap: () async {
                                      if (signInKey.currentState!.validate()) {
                                        debugPrint("+++++++++++++++++++++++++++++++++++++++++ Change Profile Controller: ${changeProfileController.currentIndex.value}");
                                        debugPrint("+++++++++++++++++++++++++++++++++++++++++ Change Nav Controller: ${navController.currentIndex.value}");
                                        await controller.logIn();
                                      }
                                    },
                                    borderRadius: 8.r,
                                  ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(SignUpScreen());
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Don’t have an account? ",
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp,
                                  color: Colors.black.withValues(alpha: 0.6),
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign up",
                                    style: GoogleFonts.dmSans(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 160.h,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomText(
                                text: "Version 1.0.0",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor),
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
