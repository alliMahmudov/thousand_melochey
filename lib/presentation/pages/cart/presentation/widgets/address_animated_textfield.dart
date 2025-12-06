import 'package:thousand_melochey/presentation/pages/cart/presentation/widgets/selection_field_widget.dart';
import 'package:thousand_melochey/presentation/pages/cart/presentation/widgets/user_addresses_modal.dart';

import '../../../../../core/imports/imports.dart';
import '../../../../../service/localizations/localization.dart';

class AddressAnimatedField extends StatelessWidget {
  final bool pickupType;
  final String districtName;
  final String address;
  final String errorMessage;

  const AddressAnimatedField({
    required this.pickupType,
    required this.districtName,
    required this.address,
    required this.errorMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: pickupType
          ? const SizedBox.shrink()
          : Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SelectionFieldWidget(
          onTap: () {
            AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
              context: context,
              modal: const UserAddressesModal(),
            );
          },
          title: "${AppLocalization.getText(context)?.address}",
          value: "$districtName $address",
          errorMessage: errorMessage,
        ),
      ),
    );
  }
}
