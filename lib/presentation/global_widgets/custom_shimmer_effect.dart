import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:thousand_melochey/contstants/app_colors.dart';

class CustomShimmerEffect extends StatelessWidget {
  final Widget child;
  final bool? isLoading;
  final bool? leaf;

  // final GlobalKey? globalKey;

  const CustomShimmerEffect(
      {super.key, required this.child, this.isLoading = false, this.leaf});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: const ShimmerEffect(
        baseColor: Color(0xffBCC1C2),
        highlightColor: Color(0xffF9FAFB),
      ),
      enabled: isLoading ?? false,
      child: leaf ?? true ? Skeleton.leaf(child: child) : child,
    );
  }

  Widget borderLoader(BuildContext context) {
    return (isLoading ?? false)
        ? AnimatedLoadingBorder(
      cornerRadius: 12.0,
      borderWidth: 2,
      duration: const Duration(milliseconds: 650),
      borderColor: Theme.of(context).primaryColor,
      child: child,
    )
        : child;
  }
}

class CustomShimmerEffectSliver extends StatelessWidget {
  final Widget child;
  final bool? isLoading;

  const CustomShimmerEffectSliver(
      {super.key, required this.child, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.sliver(
      effect: const ShimmerEffect(
        baseColor: Color(0xffBCC1C2),
        highlightColor: Color(0xffF9FAFB),
      ),
      enabled: isLoading ?? false,
      child: child,
    );
  }
}
