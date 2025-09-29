import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:thousand_melochey/service/localizations/riverpod/provider/localization_provider.dart';

class ChangeLangModal extends ConsumerStatefulWidget {
  const ChangeLangModal({super.key});

  @override
  ConsumerState<ChangeLangModal> createState() => _ChangeLangModalState();
}

class _ChangeLangModalState extends ConsumerState<ChangeLangModal> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((re) {
      final langNotifier = ref.read(langProvider(0).notifier);
      langNotifier.getLang(LocalStorage.instance.getLang(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final langNotifier = ref.read(langProvider(0).notifier);
    final langState = ref.watch(langProvider(0));
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 3,),
                Center(child: Text("${AppLocalization.getText(context)?.select_lang}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),)),
                const Spacer(flex: 2,),
                InkWell(
                  onTap: (){
                    AppNavigator.pop();
                  },
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primaryColor,
                    child: Center(
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              langNotifier.changeLang('uz');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  ListTile(
                    minTileHeight: 55.h,
                    title: const Text(
                      "O'zbek tili",
                    ),
                    trailing: CupertinoRadio(
                        inactiveColor: Theme.of(context).canvasColor,
                        activeColor: AppColors.primaryColor,
                        value: "uz",
                        groupValue: langState.localLang,
                        onChanged: (value) {
                          langNotifier.changeLang('uz');
                        }),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              langNotifier.changeLang('ru');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  ListTile(
                    minTileHeight: 55.h,
                    title: const Text(
                      "Русский язык",
                    ),
                    trailing: CupertinoRadio(
                        inactiveColor: Theme.of(context).canvasColor,
                        activeColor: AppColors.primaryColor,
                        value: "ru",
                        groupValue: langState.localLang,
                        onChanged: (value) {
                          langNotifier.changeLang('ru');
                        }),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              langNotifier.changeLang('en');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  ListTile(
                    minTileHeight: 55.h,
                    title: const Text(
                      "English",
                    ),
                    trailing: CupertinoRadio(
                        inactiveColor: Theme.of(context).canvasColor,
                        activeColor: AppColors.primaryColor,
                        value: "en",
                        groupValue: langState.localLang,
                        onChanged: (value) {
                          langNotifier.changeLang('en');
                        }),
                  ),
                ],
              ),
            ),
          ),
          const Divider(thickness: .6, color: Colors.grey),
          CustomButtonWidget(
              title: '${AppLocalization.getText(context)?.save}',
              isLoading: false,
              onTap: () {
                langNotifier.setLang(langState.localLang ?? "en", context);
                AppNavigator.pop();
              }
          ),
          10.h.verticalSpace,
        ],
      ),
    );
  }
}
