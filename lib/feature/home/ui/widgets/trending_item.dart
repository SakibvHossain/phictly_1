import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/home/data/controller/change_home_controller.dart';
import 'package:phictly/feature/home/data/controller/club_item_controller.dart';
import 'package:phictly/feature/home/data/controller/home_controller.dart';
import 'package:phictly/feature/home/data/controller/slider_controller.dart';
import 'package:phictly/feature/home/data/model/club_model.dart';
import 'package:phictly/core/helper/sheared_prefarences_helper.dart';
import 'package:phictly/feature/create_club/data/controller/change_club_controller.dart';
import 'package:phictly/feature/create_club/data/controller/club_controller.dart';
import 'package:phictly/feature/home/data/controller/bottom_nav_controller.dart';
import 'package:phictly/feature/home/data/controller/join_club_controller.dart';

class TrendingItem extends StatelessWidget {
  TrendingItem({super.key});

  final HomeController controller = Get.put(HomeController());
  final ChangeHomeController changeHomeController = Get.find<ChangeHomeController>();
  final SliderController sliderController = Get.put(SliderController());
  final ClubItemController clubItemController = Get.put(ClubItemController());
  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final BottomNavController navController = Get.put(BottomNavController());
  final ClubController clubController = Get.find<ClubController>();
  final JoinClubController joinClubController = Get.put(JoinClubController());
  final SharedPreferencesHelper sharedPreference = Get.put(SharedPreferencesHelper());
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190.h,
      child: Obx(() => _buildTrendingList(context)),
    );
  }

  Widget _buildTrendingList(BuildContext context) {
    if (clubItemController.isTrendingDataLoading.value) {
      return const Center(
        child: SpinKitWave(
          duration: Duration(seconds: 2),
          size: 15,
          color: AppColors.primaryColor,
        ),
      );
    }

    if (clubItemController.trendingDataList.isEmpty) {
      return Center(
        child: CustomText(
          text: "No trending data found",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: clubItemController.trendingDataList.length,
      itemBuilder: (context, index) => _buildClubCard(context, index),
    );
  }

  Widget _buildClubCard(BuildContext context, int index) {
    final ClubModel trending = clubItemController.trendingDataList[index];
    final String? status = trending.clubMember?.isNotEmpty ?? false ? trending.clubMember!.first.status : null;

    return Obx(() {
      final bool isExpanded = clubItemController.selectedClubIndex.value == index;
      return GestureDetector(
        onTap: () => clubItemController.toggleClubIndex(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isExpanded ? 360.w : 120.w,
          margin: EdgeInsets.only(left: 4.w, right: 4.w),
          padding: EdgeInsets.only(left: 6.w, right: 0, top: 8.h, bottom: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5.r,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildClubImage(trending),
              if (isExpanded) ...[
                SizedBox(width: 4.w),
                Expanded(child: _buildClubDetails(context, trending, status, index)),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _buildClubImage(ClubModel trending) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: CachedNetworkImage(
          imageUrl: trending.poster ?? "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
          height: 180.h,
          width: 100.w,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: SizedBox(
              height: 25.h,
              width: 25.w,
              child: const SpinKitWave(
                duration: Duration(seconds: 2),
                size: 15,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            "assets/images/placeholder_image.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildClubDetails(BuildContext context, ClubModel trending, String? status, int index) {
    final double maxValue = trending.memberSize?.toDouble() ?? 100.0;
    final double minValue = trending.count?.clubMember?.toDouble() ?? 0.0;

    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _handleClubTap(trending, status),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCustomText(
                text: trending.clubId ?? "",
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              _buildCustomText(
                text: trending.clubLabel ?? "",
                fontSize: 12.sp,
                color: Colors.black.withOpacity(0.5),
              ),
              _buildRowCustomText(
                firstText: "Title: ",
                secondText: trending.title ?? "",
                fontSize: 12.sp,
              ),
              if (trending.writer != null)
                _buildRowCustomText(
                  firstText: "Author: ",
                  secondText: trending.writer!,
                  fontSize: 12.sp,
                ),
              if (trending.totalSeasons != null)
                _buildRowCustomText(
                  firstText: "Season: ",
                  secondText: trending.totalSeasons.toString(),
                  fontSize: 12.sp,
                ),
              if (trending.totalEpisodes != null)
                _buildRowCustomText(
                  firstText: "Episode: ",
                  secondText: trending.totalEpisodes.toString(),
                  fontSize: 12.sp,
                ),
              _buildRowCustomText(
                firstText: "Club Creator: ",
                secondText: trending.admin?.username ?? trending.writer ?? "",
                fontSize: 12.sp,
                secondColor: const Color(0xff29605E),
              ),
              _buildRowCustomText(
                firstText: "Member Count: ",
                secondText: trending.memberSize?.toString() ?? "0",
                fontSize: 12.sp,
              ),
              _buildMemberSlider(context, minValue, maxValue),
              _buildRowCustomText(
                firstText: "Timeline: ",
                secondText: "${trending.timeLine ?? 0} day(s)",
                fontSize: 12.sp,
              ),
              _buildTimelineSlider(context, maxValue),
              _buildTimelineRow(trending.timeLine?.toString() ?? "0"),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 6.w,
          child: _buildActionColumn(trending, status),
        ),
      ],
    );
  }

  void _handleClubTap(ClubModel trending, String? status) async {
    if (status == "ACCPECT" && trending.id != null) {
      logger.d("Navigating to private club: ${trending.id}");
      clubController.areYouFromHome.value = true;
      await sharedPreference.setString("selectedClubId", trending.id!);
      clubController.fetchCreatedClub(trending.id!);
      navController.updateIndex(2);
      changeClubController.updateIndex(6);
    } else {
      logger.d("Private club access denied");
    }
  }

  Widget _buildCustomText({
    required String text,
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _buildRowCustomText({
    required String firstText,
    required String secondText,
    required double fontSize,
    Color? secondColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 1.h),
      child: RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        text: TextSpan(
          children: [
            TextSpan(
              text: firstText.length > 20 ? '${firstText.substring(0, 20)}...' : firstText,
              style: GoogleFonts.dmSans(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: secondText.length > 16 ? '${secondText.substring(0, 16)}...' : secondText,
              style: GoogleFonts.dmSans(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                color: secondColor ?? Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberSlider(BuildContext context, double minValue, double maxValue) {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(right: 88.w, left: 6.w),
        child: SizedBox(
          height: 15.h,
          child: Obx(() => SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackShape: const RoundedRectSliderTrackShape(),
              trackHeight: 2.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 1.0),
              overlayShape: SliderComponentShape.noOverlay,
              thumbColor: const Color(0xff29605E),
              activeTrackColor: const Color(0xff29605E),
              inactiveTrackColor: Colors.grey.shade300,
            ),
            child: Slider(
              min: 0.0,
              max: maxValue,
              value: sliderController.value.value.clamp(minValue, maxValue),
              onChanged: (val) {},
            ),
          )),
        ),
      ),
    );
  }

  Widget _buildTimelineSlider(BuildContext context, double maxValue) {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(right: 88.w, left: 2.w),
        child: SizedBox(
          height: 15.h,
          child: Obx(() => SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackShape: const RoundedRectSliderTrackShape(),
              trackHeight: 2.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
              overlayShape: SliderComponentShape.noOverlay,
              thumbColor: const Color(0xff29605E),
              activeTrackColor: const Color(0xff29605E),
              inactiveTrackColor: Colors.grey.shade300,
            ),
            child: Slider(
              min: 0.0,
              max: maxValue,
              value: sliderController.value.value.clamp(maxValue, maxValue),
              onChanged: (val) {},
            ),
          )),
        ),
      ),
    );
  }

  Widget _buildTimelineRow(String timeline) {
    return SizedBox(
      height: 16.h,
      child: Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: _buildCustomText(
                text: "1",
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(right: 70.0),
                child: _buildCustomText(
                  text: timeline,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionColumn(ClubModel trending, String? status) {
    return SizedBox(
      height: 170.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(height: 20.h, width: 20.w),
              SizedBox(width: 4.w),
              Image.asset("assets/icons/share.png", height: 20.h, width: 20.w),
            ],
          ),
          Column(
            children: [
              _buildStatusIcon(trending, status),
              _buildStatusText(status),
              SizedBox(height: 6.h),
              _buildCustomText(
                text: _formatTimeDifference(trending.startDate),
                fontSize: 9.78.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.6),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(ClubModel trending, String? status) {
    if (status == null || status == "DELETED") {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          if (trending.id == null || trending.type == null) {
            logger.e("Invalid club ID or type");
            return;
          }
          if (trending.type!.contains("PRIVATE")) {
            await joinClubController.joinPrivateClub(trending.id!);
          } else {
            await joinClubController.joinPublicClub(trending.id!);
            await clubController.fetchCreatedClub(trending.id!);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: Image.asset(
            "assets/icons/join_read_icon.png",
            height: 28.16.h,
            width: 28.52.w,
          ),
        ),
      );
    } else if (status == "PENDING") {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: Image.asset(
            "assets/icons/request_icon.png",
            height: 28.16.h,
            width: 28.52.w,
          ),
        ),
      );
    }
    return SizedBox(height: 28.16.h, width: 28.52.w);
  }

  Widget _buildStatusText(String? status) {
    if (status == null || status == "DELETED") {
      return _buildCustomText(
        text: "Join Read",
        fontSize: 9.78.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      );
    } else if (status == "PENDING") {
      return _buildCustomText(
        text: "Request",
        fontSize: 9.78.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      );
    }
    return const SizedBox.shrink();
  }

  String _formatTimeDifference(String? startDate) {
    if (startDate == null) return "Unknown time";
    final DateTime? createdAt = DateTime.tryParse(startDate);
    if (createdAt == null) return "Unknown time";

    final Duration diff = DateTime.now().toUtc().difference(createdAt.toUtc());
    if (diff.inSeconds < 60) return '${diff.inSeconds}s';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 365) return '${diff.inDays}d';
    return '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
  }
}