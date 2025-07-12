import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = Get.mediaQuery.size.width;
    final double boxSize = screenSize - 64.w;

    return Scaffold(
      body: Obx(() {
        final weather = controller.weather.value;
        final isLoading = controller.isLoading.value;

        return Container(
          width: screenSize,
          height: Get.mediaQuery.size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFF4B9AFA), Color(0xFF47BEE0)],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60.h, left: 32.w, right: 32.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.white),
                        SizedBox(width: 8.w),
                        Text(
                          controller.cityName.value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: controller.fetchWeatherData,
                      child: SvgPicture.asset(
                        'assets/images/reset.svg',
                        width: 24.w,
                        height: 24.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 중앙 날씨 아이콘
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/sunny.svg',
                    width: 210.w,
                    height: 210.h,
                  ),
                ),
              ),
              Container(
                width: boxSize,
                height: boxSize,
                margin: EdgeInsets.only(bottom: 48.h),
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.2),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: Colors.white, width: 1.w),
                ),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : weather == null
                    ? const Center(
                        child: Text(
                          '날씨 정보를 불러올 수 없습니다.',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Today, ${DateFormat('M.d').format(DateTime.now())}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '${weather.temp.round()}°',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64.sp,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 4),
                                  blurRadius: 12,
                                ),
                                Shadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 12),
                                  blurRadius: 24,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            weather.description.capitalizeFirst ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.air,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Wind',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  const Text(
                                    '|',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '${weather.windSpeed} km/h',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.water_drop,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Hum',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  const Text(
                                    '|',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '${weather.humidity}%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
