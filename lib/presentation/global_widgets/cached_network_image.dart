

import 'package:thousand_melochey/core/imports/imports.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imagePath;
  const CustomNetworkImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath ?? "",
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      placeholderFadeInDuration: Duration.zero,
      placeholder: (context, url) => Transform.scale(
          scale: 0.7,
          child: const CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
