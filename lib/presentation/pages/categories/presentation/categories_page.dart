import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/cached_network_image.dart';
import 'package:thousand_melochey/presentation/global_widgets/empty_page_template.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/provider/categories_provider.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';


@RoutePage()
class CategoriesPage extends ConsumerStatefulWidget {
  const CategoriesPage({super.key});

  @override
  ConsumerState<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ConsumerState<CategoriesPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoriesProvider.notifier).getCategories();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesProvider);
    final categories = state.categories?.data ?? [];
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          "${AppLocalization.getText(context)?.catalog}",
        ),
        centerTitle: true,
      ),
      body: state.isLoading
          ? loadingShimmer()
          : categories.isEmpty
              ? emptyState()
              : _buildCategoriesGrid(categories),
    );
  }

  Widget loadingShimmer() {
    return CustomShimmerEffect(
      isLoading: true,
      leaf: false,
      child: GridView.builder(
        padding: EdgeInsets.all(16.sp),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 12.sp,
          mainAxisSpacing: 12.sp,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Container(
                      height: 12.sp,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget emptyState() {
    return EmptyPageTemplate(
      icon: Icons.category_outlined,
      title: "${AppLocalization.getText(context)?.empty_catalog}",
      needShopButton: false,
    );
  }

  Widget _buildCategoriesGrid(List<dynamic> categories) {
    return RefreshIndicator(
      onRefresh: () => ref.read(categoriesProvider.notifier).getCategories(),
      child: GridView.builder(
        padding: EdgeInsets.all(16.sp),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 12.sp,
          mainAxisSpacing: 12.sp,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              AppNavigator.push(CategoryProductsRoute(
                  categoryName: category.name ?? "",
                  categoryId: category.id
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 110.sp,
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.only(bottom: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r),
                        ),
                        border: Border(bottom: BorderSide(color: AppColors.primaryColor.withAlpha(50)))
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r),
                        ),
                        child: CustomNetworkImage(imagePath: category.image)
                        // FadeInImage.assetNetwork(
                        //   placeholder: AppAssets.emptyImagePlaceHolder,
                        //   image: ,
                        //   imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                        //     AppAssets.emptyImagePlaceHolder,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                      )
                  ),
                  8.verticalSpace,
                  Text(
                    category.name ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
