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
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "1000 Melochey",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.verticalSpace,
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50.h,
                    width: 300.w,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Looking for utilies",
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 24.r,
                    child: const Icon(
                      Icons.settings,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 10.0.h),
                child: InkWell(
                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Item added to wishlist'),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Implement undo logic here
                          },
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Select category",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ),*/
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
