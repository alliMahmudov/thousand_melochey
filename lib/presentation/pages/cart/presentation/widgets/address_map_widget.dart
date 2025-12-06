
import 'dart:io';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:thousand_melochey/contstants/app_constants.dart';

import '../../../../../core/imports/imports.dart';
import '../../../../../service/localizations/localization.dart';

class AddressMapWidget extends ConsumerWidget {
  final bool show;

  const AddressMapWidget({super.key, required this.show});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cartProvider.notifier);
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutSine,
      child:
      show ?
      Column(
        spacing: 8,
        children: [
          Container(
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey.withAlpha(50)
              ),
              child: Row(
                spacing: 8,
                children: [
                  Text("${AppLocalization.getText(context)?.address}:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  Text("${AppLocalization.getText(context)?.shop_address}"),
                ],
              )),
          GestureDetector(
            onTap: () {
              notifier.openMap(AppConstants.shopLat, AppConstants.shopLong, "1000 Мелочей");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primaryColor.withAlpha(100))
              ),
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Stack(
                  children: [
                    IgnorePointer(
                      child: FlutterMap(
                          options: const MapOptions(
                            initialCenter: LatLng(AppConstants.shopLat, AppConstants.shopLong),
                            initialZoom: 16,
                            interactionOptions: InteractionOptions(
                              flags: InteractiveFlag.none, // ❗ Полностью отключает действия юзера
                            ),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://b.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                              userAgentPackageName:
                              Platform.isAndroid ? "uz.melochey.melochey1000" :
                              'uz.buildingProductsGroup.melochey1000',
                            ),
                            const MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(AppConstants.shopLat, AppConstants.shopLong),
                                  width: 40,
                                  height: 40,
                                  child: Icon(
                                    Icons.location_pin,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    // Прозрачный слой для обработки нажатий
                    Positioned.fill(
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ) :
          const SizedBox.shrink()
    );
  }
}
