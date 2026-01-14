import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thousand_melochey/contstants/app_colors.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.wifi_slash,
                size: 80,
                color: AppColors.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                "${AppLocalization.getText(context)?.no_internet_access}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${AppLocalization.getText(context)?.check_wifi_or_network}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
