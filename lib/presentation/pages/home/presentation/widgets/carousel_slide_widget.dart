import 'package:flutter/material.dart';
import 'package:thousand_melochey/contstants/app_colors.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/core/config/banner_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CarouselSlideWidget extends StatelessWidget {
  final BannerConfig bannerConfig;

  const CarouselSlideWidget({
    super.key,
    required this.bannerConfig,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)?.localeName ?? 'uz';
    final imagePath = bannerConfig.getImagePath(locale);
    
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          fit: BoxFit.fitWidth,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image_not_supported, size: 50),
              ),
            );
          },
        ),
      ),
    );
  }
}




