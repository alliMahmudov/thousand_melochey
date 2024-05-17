import 'package:thousand_melochey/core/imports/imports.dart';

class CustomTitleWidget extends StatelessWidget {
  const CustomTitleWidget({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.black,
          fontSize: 30.sp,
          fontWeight: FontWeight.bold),
    );
  }
}
