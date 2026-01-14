import 'package:flutter/material.dart';

class BannerConfig {
  final int id;
  final Map<String, String> localizedPaths;
  final String? actionUrl;
  final String? title;

  const BannerConfig({
    required this.id,
    required this.localizedPaths,
    this.actionUrl,
    this.title,
  });

  String getImagePath(String locale) {
    return localizedPaths[locale] ?? localizedPaths['uz'] ?? localizedPaths.values.first;
  }
}

class BannerData {
  static const List<BannerConfig> banners = [
    BannerConfig(
      id: 1,
      localizedPaths: {
        'ru': 'assets/images/banners/1-ru.jpg',
        'uz': 'assets/images/banners/1-uz.jpg',
      },
    ),
    BannerConfig(
      id: 2,
      localizedPaths: {
        'ru': 'assets/images/banners/2-ru.jpg',
        'uz': 'assets/images/banners/2-uz.jpg',
      },
    ),
    BannerConfig(
      id: 3,
      localizedPaths: {
        'ru': 'assets/images/banners/3-ru.jpg',
        'uz': 'assets/images/banners/3-uz.jpg',
      },
    ),
    BannerConfig(
      id: 4,
      localizedPaths: {
        'ru': 'assets/images/banners/4-ru.jpg',
        'uz': 'assets/images/banners/4-uz.jpg',
      },
    ),
  ];

  static List<BannerConfig> getBanners() => banners;
}
