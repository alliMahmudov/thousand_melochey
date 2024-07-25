import 'package:thousand_melochey/core/imports/imports.dart';

class SectionButtonWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const SectionButtonWidget({ required this.icon, required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 26.0.w),
        child: ListTile(
          leading: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 26,
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: AppColors.primaryColor,
            size: 26,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          shape: const Border(bottom: BorderSide(color: Colors.black12, width: 1)),
        ),
      ),
    );
  }
}
