import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/categories/all_products_widget.dart';

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

    tabController = TabController(length: notifier.tabs(context).length, vsync: this);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(homeProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "1000 МЕЛОЧЕЙ",
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
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
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                          child: CarouselSlider(
                        options: CarouselOptions(height: 150.h, viewportFraction: 0.9),
                            items: [1, 2, 3, 4].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                        borderRadius: BorderRadius.circular(12.r)
                                      ),
                                      child: Text('text $i', style: const TextStyle(fontSize: 16.0),)
                                  );
                                },
                              );
                            }).toList(),
                      )),
                      const SliverToBoxAdapter(child: SizedBox(height: 10,),),
                      const ProductsListWidget()
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
