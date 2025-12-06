
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/main/riverpod/provider/main_provider.dart';
import 'package:badges/badges.dart' as badges;

class CustomNavBar extends ConsumerWidget {
  const CustomNavBar({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final notifier = ref.read(mainProvider(0).notifier);
   final state = ref.watch(mainProvider(0));
   final cartState = ref.watch(cartProvider);
   final storage = LocalStorage.instance;
   final badgeCount = storage.isAuthenticated()
       ? cartState.cartProduct?.data?.length
       : cartState.localCartItems.length;
   final isCartEmpty = storage.isAuthenticated()
       ? (cartState.cartProduct?.data?.isNotEmpty ?? false)
       : storage.getLocalCart().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(
          notifier.navItem.length,
              (index) => Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: (){
                notifier.incrementPageIndex(index);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                              child: Icon(
                                  state.indexPage == index ?
                                  notifier.selectedIcons[index] :
                                  notifier.icons[index],
                                  color: AppColors.primaryColor,
                                  size: 30),
                            ),
                          ),
                          Text(
                            notifier.labels(context)[index],
                            style: const TextStyle(
                              fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                      isCartEmpty && index == 3 ?
                      Positioned(
                          left: 30,
                          bottom: 32,
                          child: badges.Badge(
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: AppColors.primaryColor.withRed(100)
                            ),
                            badgeContent: Text("$badgeCount",
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.white
                              ),
                            ),
                          )) : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
                      )

        ),
      ),
    );
  }
}
