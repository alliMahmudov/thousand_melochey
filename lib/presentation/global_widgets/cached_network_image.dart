

import 'package:thousand_melochey/core/imports/imports.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imagePath;
  const CustomNetworkImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath ?? "",
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
