import '../../../../../core/imports/imports.dart';

class OrderContactInfoWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const OrderContactInfoWidget({super.key, required this.title, required this.subTitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.sp, color: AppColors.primaryColor),
        4.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12.sp, color: Colors.black54),
            ),
            2.verticalSpace,
            Text(
              subTitle,
              style: TextStyle(fontSize: 13.sp, height: 1.25),
            ),
          ],
        ),
      ],
    );
  }
}
