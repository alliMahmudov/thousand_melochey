
import 'package:flutter/cupertino.dart';

import '../../../../../core/imports/imports.dart';
import '../../data/all_adresses_response.dart';

class UserAddressWidget extends StatelessWidget {
  final Address? address;
  final Function() deleteOnTap;
  final Function() editOnTap;
  const UserAddressWidget({
    required this.deleteOnTap,
    required this.editOnTap,
    this.address,
    super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:  BorderRadius.all(Radius.circular(12))
      ),
      leading: Container(
        width: 44.r,
        height: 44.r,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.location_pin,
          color: AppColors.primaryColor,
          size: 22.sp,
        ),
      ),
      title: Text(
        address?.addressLine1 ?? '-',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle:  Row(
        children: [
        Icon(
        CupertinoIcons.building_2_fill,
        size: 16.sp,
        color: Colors.grey.shade600,
      ),
        6.horizontalSpace,
        Flexible(
          child: Text(
            "${address?.city}, ${address?.districtName}",
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade700,
            ),
          ),
        )]),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: (){
                editOnTap.call();
              },
              icon: Icon(
                CupertinoIcons.pencil_circle,
                color: AppColors.primaryColor,
                size: 24.sp,
              ),
            ),
            IconButton(
              onPressed: (){
                deleteOnTap.call();
              },
              icon: Icon(
                CupertinoIcons.trash_circle,
                color: AppColors.primaryColor,
                size: 24.sp,
              ),
            ),
          ],
        ),
      )
    );
  }
}