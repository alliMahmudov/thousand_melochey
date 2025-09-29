import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/categories/all_products_widget.dart';
import 'package:thousand_melochey/presentation/pages/catogories/presentation/widgets/category_products.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;


  @override
  void didChangeDependencies() {
    final notifier = ref.read(homeProvider.notifier);

    tabController =
        TabController(length: notifier.tabs(context).length, vsync: this);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(homeProvider.notifier);
    final state = ref.watch(homeProvider);
    final favoriteNotifier = ref.read(favoritesProvider.notifier);
    final cartNotifier = ref.read(cartProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "1000 Melochey",
          ),
          centerTitle: true,
        ),
        body:
        RefreshIndicator(
          onRefresh: (){
            return notifier.getProducts(isRefresh: true);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoSearchTextField(
                    controller: notifier.searchTextFieldController,
                    onChanged: (value){
                      notifier.getProducts(
                        searchQuery: notifier.searchTextFieldController.text,
                        isRefresh: true
                      );
                    },
                  ),
                ),
                const Expanded(
                  child: CustomScrollView(
                    slivers: [
                      ProductsListWidget()
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
