
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/main/riverpod/provider/main_provider.dart';


class CustomNavBar extends ConsumerWidget {
  const CustomNavBar({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final notifier = ref.read(mainProvider(0).notifier);
   final state = ref.watch(mainProvider(0));

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: AppColors.white,
          height: 0.105.sh,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(
              notifier.navItem.length,
                  (index) =>
              // LocalStorage.instance.getUserType() == "OWNER"
              //     ? Expanded(
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Material(
              //               color: AppColors.white,
              //               child: Ink(
              //                 height: 40.h,
              //                 width: 65.w,
              //                 decoration: BoxDecoration(
              //                     color: state.indexPage == index
              //                         ? AppColors.primaryColor
              //                         : AppColors.white,
              //                     borderRadius: BorderRadius.circular(20)),
              //                 child: InkWell(
              //                   borderRadius: BorderRadius.circular(20),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(3.0),
              //                     child: Icon(notifier.icons[index],
              //                         color: state.indexPage != index
              //                             ? AppColors.primaryColor
              //                             : AppColors.white,
              //                         size: state.indexPage == index ? 30 : 35),
              //                   ),
              //                   onTap: () {
              //                     // if(index != (state.navItem.length -1) || LocalStorage.instance.getNumber() != "your number" ) {
              //                     LocalStorage.instance.getUserType() == "OWNER"
              //                         ? notifier.incrementPageIndex(index)
              //                         : index != 2
              //                             ? notifier.incrementPageIndex(index)
              //                             : null;
              //                     // }else{
              //                     //   context.router.pushNamed("/login");
              //                     // }
              //                   },
              //                 ),
              //               ),
              //             ),
              //             AnimatedCrossFade(
              //               sizeCurve: Curves.easeIn,
              //               duration: const Duration(milliseconds: 150),
              //               firstChild: Text(
              //                 notifier.labels(context)[index],
              //                 style: const TextStyle(
              //                     fontWeight: FontWeight.w600,
              //                     color: AppColors.primaryColor),
              //               ),
              //               secondChild: const SizedBox(),
              //               crossFadeState: state.indexPage == index
              //                   ? CrossFadeState.showFirst
              //                   : CrossFadeState.showSecond,
              //             ),
              //           ],
              //         ),
              //       )
              //     :

                Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      color: AppColors.white,
                      child: Ink(
                        height: 40.h,
                        width: 65.w,
                        decoration: BoxDecoration(
                            color: state.indexPage == index
                                ? AppColors.primaryColor
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(notifier.icons[index],
                                color: state.indexPage != index
                                    ? AppColors.primaryColor
                                    : AppColors.white,
                                size: state.indexPage == index
                                    ? 30
                                    : 35),
                          ),
                          onTap: () {
                            // if(index != (state.navItem.length -1) || LocalStorage.instance.getNumber() != "your number" ) {
                           /* LocalStorage.instance.getUserType() ==
                                "OWNER"
                                ? notifier.incrementPageIndex(index)
                                : index != 2
                                ? notifier
                                .incrementPageIndex(index)
                                : null;*/

                            notifier
                                .incrementPageIndex(index);

                            // }else{
                            //   context.router.pushNamed("/login");
                            // }
                          },
                        ),
                      ),
                    ),
                    AnimatedCrossFade(
                      sizeCurve: Curves.easeIn,
                      duration: const Duration(milliseconds: 150),
                      firstChild: Text(
                        notifier.labels(context)[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      ),
                      secondChild: const SizedBox(),
                      crossFadeState: state.indexPage == index
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                    ),
                  ],
                ),
              )

            ),
          ),
        ),
      ],
    );
  }
}
