import 'package:flutter/material.dart';
import 'package:thousand_melochey/contstants/app_colors.dart';
import 'package:thousand_melochey/core/imports/imports.dart';

class CarouselSlideWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color accentColor;
  final int slideIndex;

  const CarouselSlideWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.slideIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: accentColor.withAlpha(40),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            // Фоновый градиент
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      accentColor.withOpacity(0.03),
                      accentColor.withOpacity(0.01),
                      AppColors.white,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
            // Декоративные круги разных размеров
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 140.w,
                height: 140.w,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      accentColor.withOpacity(0.12),
                      accentColor.withOpacity(0.0),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: -10,
              right: 20,
              child: Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.06),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              right: 40,
              child: Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.04),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Градиентная полоса слева с эффектом свечения
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 5.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      accentColor,
                      accentColor.withOpacity(0.8),
                      accentColor.withOpacity(0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
            // Основной контент
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                children: [
                  // Иконка в премиальном контейнере
                  Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          accentColor,
                          accentColor.withOpacity(0.8),
                          accentColor.withOpacity(0.6),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: accentColor.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 2),
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Внутренний блик
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // Иконка
                        Center(
                          child: Icon(
                            icon,
                            size: 32.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 18.w),
                  // Текст с улучшенной типографикой
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                            height: 1.35,
                            letterSpacing: -0.5,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.02),
                                offset: const Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        // Декоративная линия с градиентом
                        Container(
                          width: 50.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                accentColor,
                                accentColor.withOpacity(0.5),
                                accentColor.withOpacity(0.2),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(2.r),
                            boxShadow: [
                              BoxShadow(
                                color: accentColor.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Декоративные точки
            Positioned(
              bottom: 12.h,
              left: 20.w,
              child: Row(
                children: List.generate(3, (index) {
                  return Container(
                    margin: EdgeInsets.only(right: 4.w),
                    width: 4.w,
                    height: 4.w,
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.3 - (index * 0.1)),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




