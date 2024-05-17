import 'package:thousand_melochey/core/imports/imports.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryWidget(
      {required this.title, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 10)]),
      height: 50.h,
      width: 80.w,
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isSelected ? AppColors.white : Colors.black,
        ),
      ),
    );
  }
}
