import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/categories/all_products_widget.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/categories/electronics_widget.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/categories/gloves_widget.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/categories/screwdrivers_widget.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/categories/tools_widget.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "1000 Melochey",
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.2),
                      borderRadius: BorderRadius.circular(12)),
                  child: TabBar(
                    isScrollable: true,
                    padding: const EdgeInsets.all(4),
                    controller: tabController,
                    splashBorderRadius: BorderRadius.circular(12.r),
                    // indicatorColor: AppColors.red,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black26,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 0.1,
                    indicator: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    tabs: notifier.tabs(context),
                  ),
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: tabController,
                children: const [
                  ProductsListWidget(),
                  GlovesWidget(),
                  ScrewdriversWidget(),
                  ElectronicWidget(),
                  ToolsWidget()
                ],
              ))
            ],
          ),
        ));
  }
}
