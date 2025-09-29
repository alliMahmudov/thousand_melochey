import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/contstants/app_assets.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/catogories/presentation/riverpod/provider/categories_provider.dart';
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
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Section
          // AnimatedContainer(
          //   duration: const Duration(milliseconds: 300),
          //   padding: EdgeInsets.all(16.sp),
          //   decoration: BoxDecoration(
          //     color: AppColors.primaryColor,
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(20),
          //       bottomRight: Radius.circular(20),
          //     ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: AppColors.primaryColor.withOpacity(0.3),
          //         blurRadius: 15,
          //         offset: const Offset(0, 5),
          //       ),
          //     ],
          //   ),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: AppColors.white,
          //       borderRadius: BorderRadius.circular(12.r),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(0.1),
          //           blurRadius: 8,
          //           offset: const Offset(0, 2),
          //         ),
          //       ],
          //     ),
          //     child: Stack(
          //       children: [
          //         CupertinoSearchTextField(
          //           controller: _searchController,
          //           onChanged: _onSearchChanged,
          //           placeholder: "Поиск категорий...",
          //           style: const TextStyle(fontSize: 16),
          //           decoration: BoxDecoration(
          //             color: AppColors.white,
          //             borderRadius: BorderRadius.circular(12.r),
          //           ),
          //         ),
          //         if (isSearchLoading)
          //           Positioned(
          //             right: 12.sp,
          //             top: 0,
          //             bottom: 0,
          //             child: Center(
          //               child: SizedBox(
          //                 width: 16.sp,
          //                 height: 16.sp,
          //                 child: CircularProgressIndicator(
          //                   strokeWidth: 2,
          //                   valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          //                 ),
          //               ),
          //             ),
          //           ),
          //       ],
          //     ),
          //   ),
          // ),
          
          // // Categories Section
          // if (categories.isNotEmpty && !isSearching) ...[
          //   Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
          //     child: Row(
          //       children: [
          //         Icon(
          //           Icons.category_rounded,
          //           color: AppColors.primaryColor,
          //           size: 20.sp,
          //         ),
          //         SizedBox(width: 8.sp),
          //         Text(
          //           "Категории",
          //           style: TextStyle(
          //             fontSize: 16.sp,
          //             fontWeight: FontWeight.w600,
          //             color: Colors.grey[800],
          //           ),
          //         ),
          //         const Spacer(),
          //         Text(
          //           "${categories.length} категорий",
          //           style: TextStyle(
          //             fontSize: 12.sp,
          //             color: Colors.grey[600],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   Container(
          //     height: 80.h,
          //     margin: EdgeInsets.only(bottom: 16.sp),
          //     child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       padding: EdgeInsets.symmetric(horizontal: 16.sp),
          //       itemCount: categories.length + 1, // +1 for "All" category
          //       itemBuilder: (context, index) {
          //         final isSelected = selectedCategoryIndex == index;
          //         final categoryName = index == 0 ? "Все" : categories[index - 1].name ?? "";
          //
          //         return AnimatedContainer(
          //           duration: const Duration(milliseconds: 300),
          //           curve: Curves.easeInOut,
          //           margin: EdgeInsets.only(right: 12.sp),
          //           padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 12.sp),
          //           decoration: BoxDecoration(
          //             color: isSelected ? AppColors.primaryColor : AppColors.white,
          //             borderRadius: BorderRadius.circular(25.r),
          //             border: Border.all(
          //               color: isSelected ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.3),
          //               width: 1.5,
          //             ),
          //             boxShadow: [
          //               BoxShadow(
          //                 color: isSelected
          //                     ? AppColors.primaryColor.withOpacity(0.3)
          //                     : Colors.black.withOpacity(0.08),
          //                 blurRadius: isSelected ? 12 : 8,
          //                 offset: const Offset(0, 2),
          //               ),
          //             ],
          //           ),
          //           child: InkWell(
          //             onTap: () => _onCategorySelected(index, categoryName),
          //             child: Center(
          //               child: Text(
          //                 categoryName,
          //                 style: TextStyle(
          //                   color: isSelected ? AppColors.white : AppColors.primaryColor,
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: 14.sp,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ],
          
          // Categories Grid Section
          if (categories.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
              child: Row(
                children: [
                  Icon(
                    Icons.grid_view_rounded,
                    color: AppColors.primaryColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.sp),
                  Text(
                    "Все категории",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          Expanded(
            child: state.isLoading
                ? loadingShimmer()
                : categories.isEmpty
                    ? emptyState()
                    : _buildCategoriesGrid(categories),
          ),
        ],
      ),
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
        itemCount: 6,
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.category_outlined,
              size: 80.sp,
              color: Colors.grey[400],
            ),
          ),
          24.verticalSpace,
          Text(
            "Нет доступных категорий",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
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
              AppNavigator.push(CategoryProductsRoute(categoryName: category.name ?? ""));
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
                        child: FadeInImage.assetNetwork(
                          placeholder: AppAssets.emptyImagePlaceHolder,
                          image: category.image,
                          imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                            AppAssets.emptyImagePlaceHolder,
                            fit: BoxFit.cover,
                          ),
                        ),
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
