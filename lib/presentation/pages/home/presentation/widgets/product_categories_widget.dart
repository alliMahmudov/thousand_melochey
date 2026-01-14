import 'package:skeletonizer/skeletonizer.dart';
import 'package:thousand_melochey/presentation/global_widgets/cached_network_image.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/provider/categories_provider.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/main/riverpod/provider/main_provider.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

class ProductCategoriesWidget extends ConsumerWidget {
  const ProductCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoriesProvider);

    final categories = state.categories?.data ?? [];
    if (state.isLoading) {
      return SizedBox(
        height: 140.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemBuilder: (BuildContext context, int index) {
              return CustomShimmerEffect(
                isLoading: state.isLoading,
                leaf: true,
                child: const CategorySkeletonItem(),
              );
          },
        ),
      );
    }

    if (categories.isNotEmpty) {
      return SizedBox(
        height: 140.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length + 1,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemBuilder: (context, index) {
            if (index == categories.length) {
              // Custom 'See all categories' item
              return GestureDetector(
                onTap: () {
                  ref.read(mainProvider(0).notifier).incrementPageIndex(1);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    spacing: 8,
                    children: [
                      Container(
                        width: 90.r,
                        height: 90.r,
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.list,
                          size: 32.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Text(
                          '${AppLocalization.getText(context)?.all_categories}',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            final category = categories[index];

            return GestureDetector(
              onTap: () {
                AppNavigator.push(CategoryProductsRoute(categoryName: "${category.name}", categoryId: category.id ?? 0));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  spacing: 8,
                  children: [
                    Container(
                      width: 90.r,
                      height: 90.r,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: category != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child:
                        CustomNetworkImage(imagePath: category.image!),
                      ) : Icon(
                        Icons.category,
                        size: 32.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 80.w,
                      child: Text(
                        category.name ?? 'Category',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return _buildEmptyState();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No categories found',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
    );
  }

}

class CategorySkeletonItem extends StatelessWidget {
  const CategorySkeletonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: Column(
        children: [
          // КАРТИНКА
          Skeleton.leaf(
            child: Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          // ТЕКСТ
          Container(
            width: 70.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}
