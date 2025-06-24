import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/components/custom_text_field.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/core/validation/email_validation.dart';
import 'package:phictly/feature/auth/data/controller/sign_in_controller.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/auth/ui/screens/sign_up_screen.dart';
import 'package:phictly/feature/home/ui/screens/home_nav_screen.dart';
import '../../../../core/utils/image_path.dart';
import '../../../../core/validation/password_validation.dart';

class ConfirmSignUpScreen extends StatelessWidget {
  ConfirmSignUpScreen({super.key});

  final SignInController controller = Get.put(SignInController());

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
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                                text: "Sign up",
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: CustomText(
                              text: "Welcome to Phictly. Enter your email to start \nyour next read. or watch.",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withValues(alpha: 0.6),
                            ),
                          ),

                          SizedBox(
                            height: 24,
                          ),

                          CustomTextField(
                            validator: validateEmail,
                            hintText: "email",
                            focusNode: controller.emailFocusNode,
                            nextFocus: controller.passwordFocusNode,
                            prefixIcon: Icons.email,
                          ),

                          SizedBox(
                            height: 24,
                          ),

                          RichText(
                            text: TextSpan(
                              text: "By signing up you agree to Phictly's ",
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                                color: Colors.black.withValues(alpha: 0.6),
                              ),
                              children: [
                                TextSpan(
                                  text: "Terms of Service",
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    debugPrint("++++++++++++++++++++You have tapped on Terms of Service");
                                  } ,
                                  style: GoogleFonts.dmSans(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                                TextSpan(
                                  text: " and ",
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                      color: Colors.black.withValues(alpha: 0.6),
                                    )
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    debugPrint("++++++++++++++++++++You have tapped on Privacy Policy");
                                  } ,
                                  style: GoogleFonts.dmSans(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                                TextSpan(
                                    text: ". You agree that your contact information will be shared with our partners for marketing purposes",
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                      color: Colors.black.withValues(alpha: 0.6),
                                    )
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 30.h,
                          ),

                          CustomButton(
                            text: "Continue",
                            onTap: (){
                              if (signInKey.currentState!.validate()) {
                                Get.to(HomeNavScreen());
                              }
                            },
                            borderRadius: 8.r,
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          
                          Row(
                            children: [
                              Expanded(child: Divider(color: Colors.black.withValues(alpha: 0.6),),),
                              SizedBox(width: 4.w,),
                              CustomText(text: "Or", fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black.withValues(alpha: 0.6),),
                              SizedBox(width: 4.w,),
                              Expanded(child: Divider(color: Colors.black.withValues(alpha: 0.6),),),
                            ],
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/icons/google.png", height: 40.h, width: 40.h,),
                                SizedBox(width: 30.h,),
                                Image.asset("assets/icons/facebook.png", height: 40.h, width: 40.h,),
                              ],
                            ),
                          ),

                          SizedBox(height: 30.h,),

                          GestureDetector(
                            onTap: (){
                              Get.to(SignUpScreen());
                            },

                            child: RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp,
                                  color: Colors.black.withValues(alpha: 0.6),
                                ),
                                children: [
                                  TextSpan(
                                    text: "Log in",
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
                            height: 35.h,
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
