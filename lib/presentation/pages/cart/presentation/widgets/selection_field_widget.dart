import '../../../../../core/imports/imports.dart';
import '../../../../../service/localizations/localization.dart';

class SelectionFieldWidget extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String value;
  final String errorMessage;
  const SelectionFieldWidget({
    required this.onTap,
    required this.title,
    required this.value,
    required this.errorMessage,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor),
        ),
        InkWell(
          onTap: () {
            onTap.call();
          },
          child: Container(
            height: 51,
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: errorMessage.isEmpty ? Colors.grey : AppColors.red)
            ),
            alignment: Alignment.centerLeft,
            child: Text(value, style: TextStyle(
                fontSize: 14.sp
            ),),
          ),
        ),
        if(errorMessage.isNotEmpty) Text(errorMessage, style: TextStyle(
            color: Colors.red,
            fontSize: 14.sp
        ),)
      ],
    );
  }
}
